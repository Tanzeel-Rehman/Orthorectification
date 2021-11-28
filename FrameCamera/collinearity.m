function [x,y]=collinearity(X,Y,Z,IOPs,EOPs)
%% Inputs:
%EOPs: 1x6 (one image at a time) vector of the EOPs = [ Omega, Phi, Kappa,Xo,Yo,Zo]
%IOPs: 1x9 vector of the IOPs = [ xp, yp, c,k1,k2,k3,p1,p2,p3]
% X,Y,Z: The ground coordinates of the Orthophoto cell. 
% Output: 
% [x,y]: The image coordinates corresponding to the ground coordinates of the specific orthophoto cell 
%Extract the Xo,Yo,Zo from the EOPs
Xo=EOPs(1,4); Yo=EOPs(1,5); Zo=EOPs(1,6);
%Get the prescpective center coordinates from the IOPs
Xp = IOPs(1,1);  Yp = IOPs(1,2); c= IOPs(1,3);
%Get the Rotation matrix
R_Mat=R_Matrix_Generator(EOPs(1,1),EOPs(1,2),EOPs(1,3));
%Get the elements of 3 x 3 rotation matrix 
r11=R_Mat(1,1);      r12=R_Mat(1,2);       r13=R_Mat(1,3);
r21=R_Mat(2,1);      r22=R_Mat(2,2);       r23=R_Mat(2,3);
r31=R_Mat(3,1);      r32=R_Mat(3,2);       r33=R_Mat(3,3);

%Get the image coordinates from the collinearity equation. These aren't
%true coordinates as they are still effected by the distortion
x=Xp-c*((r11*(X-Xo)+r21*(Y-Yo)+r31*(Z-Zo))/(r13*(X-Xo)+r23*(Y-Yo)+r33*(Z-Zo)));
y=Yp-c*((r12*(X-Xo)+r22*(Y-Yo)+r32*(Z-Zo))/(r13*(X-Xo)+r23*(Y-Yo)+r33*(Z-Zo)));
%Get the disortion parameters
XY_distortion= Distortion_Cumulative(x,y, IOPs);
%Get the x and y distortions
distortion_x= XY_distortion (1);       distortion_y = XY_distortion (2);
%Add these distortions to the image coordinates to obtain the true
%coordinates
x = x+distortion_x;
y=y+distortion_y;

end
