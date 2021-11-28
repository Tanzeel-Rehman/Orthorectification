function R_Mat=R_Matrix_Generator(omega,phi,kappa)
%% inputs: 
%   omega, phi, kappa: 3 roation angles for primary, secondary and tertiary rotation (in degrees) 
    %Take ground coordinates to image coordinates???????????????????????????
%% ouput:  A 3 x3 rotation matrix 
%degrees to rad
omega = omega*(pi/180);
phi = phi*(pi/180);
kappa = kappa*(pi/180);
%Get the elements of the matrix
r11 = cos(phi)*cos(kappa);
r12 = -cos(phi)*sin(kappa);
r13 = sin(phi);
r21 = cos(omega)*sin(kappa)+ sin(omega)*sin(phi)*cos(kappa);
r22 = cos(omega)*cos(kappa)- sin(omega)*sin(phi)*sin(kappa);
r23 = -sin(omega)* cos(phi);
r31 = sin(omega)*sin(kappa) - cos(omega)*sin(phi)* cos(kappa);
r32 = sin(omega)*cos(kappa) + cos(omega)*sin(phi)* sin(kappa);
r33 = cos(omega)*cos(phi);
R_Mat= [r11, r12,r13; r21, r22, r23; r31, r32, r33 ];

end