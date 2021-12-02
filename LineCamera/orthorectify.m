function ortho_img=orthorectify(DSM,gsd,IOPs,IMU,GPS,Frameindex,img,int_method)
%% inputs: 
%       DSM: Digital Surface model represented by a 1 x 1 structure containing x y and z information 
%       gsd: Cell size for the orthophoto    
%       IOPs: 1x11 vector of the IOPs = [ xp, yp, c,k1,k2,k3,p1,p2,p3,x_pixel_size,y_pixel_size]
%       EOPs: 1x6 vector of the EOPs = [ Omega, Phi, Kappa,Xo,Yo,Zo]
%       img: A digtial image which need to be rectified

%% ouputs:  An orthorectified image with an extent of the DSM

%---------------------- Orhtophoto limits ----------------------%
%Define the image limits 
DSM_Xmax=max(DSM.x);% Get the max X from the DSM XYZ file
DSM_Xmin=min(DSM.x);% Get the min X from the DSM XYZ file
DSM_Ymax=max(DSM.y);
DSM_Ymin=min(DSM.y);
%define ortho height and width (resolution)
ortho_height = round((DSM_Ymax-DSM_Ymin)/gsd)+1;
ortho_width = round((DSM_Xmax-DSM_Xmin)/gsd)+1;
%creating an empty image for orthophot
ortho_img = zeros(ortho_height,ortho_width,3); %3rd dimesnion is spectral dimension 
% Reshape 1D array to a new 2D array with size similar to the
% Orthorectified image
DSM_Z=reshape(DSM.z,[ortho_width,ortho_height])';
[m, n, ~]=size(img);
%Procedure: 
%Get the time stamp for each frame.
%Find the closest time stamps in the IMU file and do the linear
%interpolation of the time stamps. Get the UTC time of the day for the interpolated
%time in IMU
%Use the UTC time and compare this time with GPS time and get the EOPs of
%each frame based on the compared UTC time.

EOPs=GetEOPs(IMU,GPS,Frameindex); 

% %---------------------- Orthorectification --------------------%
for r = 1:ortho_height
    for c = 1:ortho_width
        %Calculating the Lat and Long based on the row and column number
        X = DSM_Xmin + (c-1) * gsd + gsd/2;
        Y = DSM_Ymax - (r-1) * gsd - gsd/2;
        Z=DSM_Z(r,c);
        % Now calculate the Eucledian distance between the current orthophoto cell and all the frames
        %Find the minimum distance and it will be closest frmae. This is the approximated frame that
        %potentially can belong to this cell
        [~, EOPs_Idx] = min((EOPs(:,2)-X).^2+(EOPs(:,3)-Y).^2);
        EOPs_current=EOPs_Idx;
        iteration = 0;  delta_Idx = 1;
        while iteration<15
            if EOPs_Idx>0 && EOPs_Idx<size(Frameindex,1)+1 && abs(delta_Idx)>=1
            %Use this estimated position to get the estimated Image/pixel coordinates
            estimated_EOPs=EOPs(EOPs_Idx,:);
            [x_est,y_est] = collinearity(X,Y,Z,estimated_EOPs,IOPs);
            EOPs_current=EOPs_Idx;
            if EOPs_Idx+1>size(Frameindex,1)
                next_EOPs=EOPs(EOPs_Idx-1,:);
                [x_new,y_new] = collinearity(X,Y,Z,next_EOPs,IOPs);
                delt_x = x_est-x_new;
            else
                next_EOPs=EOPs(EOPs_Idx+1,:);
                [x_new,y_new] = collinearity(X,Y,Z,next_EOPs,IOPs);
                delt_x = x_new-x_est;
            end
            delta_Idx=x_est/delt_x;
            EOPs_Idx=EOPs_Idx-fix(delta_Idx);
            iteration=iteration+1;
            else
                break;
            end
        end
        %Interpolate the color value based on the image coordinates and
        %the selected interpolation method
        y_raw = round(y_est);
        x_raw = EOPs_current-1;
        x_final = x_est;
                
        if x_raw > 0&& x_raw<=2256 && y_raw >0 && y_raw <= 640 && (EOPs_current-fix(x_final/delt_x)) < (size(Frameindex,1)+1) && (EOPs_current-fix(x_final/delt_x))>0 
            ortho_img(r,c,:)=img(x_raw,y_raw,:);
%             switch int_method
%                 case {'Nearest'}
%                     [g] = nearest_int(img,x_raw,y_raw,3);
%                     ortho_img(r,c,:) = g;
%             end
        end
    end               
end
ortho_img = uint8(ortho_img);
end