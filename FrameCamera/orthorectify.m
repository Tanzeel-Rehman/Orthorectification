function ortho_img=orthorectify(DSM,gsd, IOPs,EOPs,img,int_method)
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
ortho_img = zeros(ortho_height,ortho_width,size(img,3)); %3 is used to define rgb image 
%ortho_img=num2cell(ortho_img);
% Reshape 1D array to a new 2D array with size similar to the
% Orthorectified image
DSM_Z=reshape(DSM.z,[ortho_width,ortho_height])';


%---------------------- Orthorectification --------------------%
for r = 1:ortho_height
    for c = 1:ortho_width
        %Calculating the Lat and Long based on the row and column number
        %X = DSM_Xmin + (c-1) * d + d/2; Y = DSM_Ymax - (r-1) * d - d/2;
        X = DSM_Xmin + (c-1) * gsd + gsd/2;
        Y = DSM_Ymax - (r-1) * gsd - gsd/2;
        %index=find(DSM.x==X & DSM.y==Y);
        %Z= DSM.z(index);
        %distX=abs(DSM.x-X); minDistX=min(distX);
        %distY=abs(DSM.y-Y); minDistY=min(distY);
        %idx=find(distX==minDistX & distY==minDistY);
        %Z=DSM.z(idx);
        Z=DSM_Z(r,c);
        
        if isnan(Z)
            ortho_img(r,c) = 0;
        else
            [x,y]=collinearity(X,Y,Z,IOPs,EOPs);%Get the image coordinates
            [i,j]=Pixelcoordinates(x,y,img,IOPs); %Chnage these image coordinates to the pixel coordinates
            %Interpolate the color value based on the image coordinates and
            %the selected interpolation method
            switch int_method    

                case {'Nearest'}                    
                    if size(img,3)>1
                        for n = 1:3
                            [g] = nearest_int(img,i,j,n);
                            ortho_img(r,c,n) = g;
                        end
                        
                    else
                        [g] = nearest_int(img,i,j,1);
                        ortho_img(r,c) = g;
                        
                    end
                    
                case {'Bilinear'}
                    if size(img,3)>1
                        for n = 1:3
                            [g] = bilinear_int(img,i,j,n);
                            ortho_img(r,c,n) = g;
                        end
                        
                    else
                        [g] = bilinear_int(img,i,j,1);
                        ortho_img(r,c) = g;
                    end

                case {'Bicubic'}
                    if size(img,3)>1
                        for n = 1:3
                            [g] = bicubic_int(img,i,j,n);
                            ortho_img(r,c,n) = g;
                        end
                        
                     else
                         [g] = bicubic_int(img,i,j,1);
                         ortho_img(r,c) = g;
                    end
            end
        end
        %Procedure:
        %Get the rotation from EOPS
        %Get the IOPs and use these IOPS in the collinearity
        %Get the Xo, Yo and Zo from the EOPS for each frame
        % Get the x,y from the collinearity using rotation, distortion EOPs
        % and IOPs
        %Change the x, y coordinate (from the center of the image) to image coordinates (row column)
        %Implement the interpolation
        
        
%         if (x2>0) && (x2<size(img,2))
%             ortho_img(r,c)=[x2];
%         else            
%             ortho_img(r,c)= NaN;
%         end
    end
    ortho_img = uint8(ortho_img);
end


end