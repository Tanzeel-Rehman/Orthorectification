function [x,y]=collinearity(X,Y,Z,EOPs,IOPs)
%% Inputs:
%EOPs: 1x6 (one image at a time) vector of the EOPs = [ Omega, Phi, Kappa,Xo,Yo,Zo]
%IOPs: 1x9 vector of the IOPs = [ xp, yp, c,k1,k2,k3,p1,p2,p3]
% X,Y,Z: The ground coordinates of the Orthophoto cell. 
% Output: 
% [x,y]: The image coordinates corresponding to the ground coordinates of the specific orthophoto cell 
%Extract the Xo,Yo,Zo from the EOPs
Xp=0; Yp=0; y_p=320; c=IOPs(1,1);
Xo=EOPs(1,2); Yo=EOPs(1,3); Zo=EOPs(1,4);
%R_NED_ENU = Rotation(180.0,0.0,-90.0);
R_NED_ENU = R_Matrix_Generator(-180.0,0.0,90.0)';
%Get the Rotation matrix
%R_Mat=Rotation(0.0,0.0,EOPs(1,7))*Rotation(0.0,EOPs(1,6),0.0)*Rotation(EOPs(1,5),0.0,0.0);
R_Mat=R_Matrix_Generator(EOPs(1,5),EOPs(1,6),EOPs(1,7));
R_Mat=R_Mat*R_NED_ENU;
%Get the elements of 3 x 3 rotation matrix 
r11=R_Mat(1,1);      r12=R_Mat(1,2);       r13=R_Mat(1,3);
r21=R_Mat(2,1);      r22=R_Mat(2,2);       r23=R_Mat(2,3);
r31=R_Mat(3,1);      r32=R_Mat(3,2);       r33=R_Mat(3,3);

%Get the image coordinates from the collinearity equation. These aren't
%true coordinates as they are still effected by the distortion,but we
%assumed zero distortion
x=Xp+c*((r11*(X-Xo)+r12*(Y-Yo)+r13*(Z-Zo))/(r31*(X-Xo)+r32*(Y-Yo)+r33*(Z-Zo)));
y=Yp+c*((r21*(X-Xo)+r22*(Y-Yo)+r23*(Z-Zo))/(r31*(X-Xo)+r32*(Y-Yo)+r33*(Z-Zo)));
%Change the image coordinates to pixel coordinates
y=y+y_p;
end
