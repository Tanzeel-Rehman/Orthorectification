function [Distor_Cumm] = Distortion_Cumulative(x,y,IOPs)
%% inputs: 
%       x,y: image coordinates ( x , y) 
%       IOPs: 1x10 vector of the IOPs = [ xp, yp, c,k1,k2,k3,p1,p2,p3]
%% ouputs:  Cummulative distrotion in X and Y

% Get all the IOPs including the Distortion parameters
Xp = IOPs(1,1);  Yp = IOPs(1,2);
k1 = IOPs(1,4);  k2 = IOPs(1,5);   k3 = IOPs(1,6);
p1 = IOPs(1,7);  p2 = IOPs (1,8);  p3 = IOPs(1,9);
% Get the Image Coordinates
%x=ImageCoordinates(1);  y=ImageCoordinates(2);
% Get the radial and decedntric lens distortion 
r = sqrt((x-Xp)^2 + (y-Yp)^2);
radial_x =(x-Xp)*(k1 *r^2 + k2*r^4 + k3*r^6);
radial_y =(y-Yp)*(k1 *r^2 + k2*r^4 + k3*r^6);
decentric_x =(1 + p3*r^2)*(p1*(r^2 + 2*(x-Xp)^2)+2*p2*(x-Xp)*(y-Yp));
decentric_y =(1 + p3*r^2)*(p2*(r^2 + 2*(y-Yp)^2)+2*p1*(x-Xp)*(y-Yp));
% Get the Cummulative Distortion
distortion_x = radial_x + decentric_x;
distortion_y = radial_y + decentric_y;
%Return the final distortion
[Distor_Cumm] =[distortion_x, distortion_y];

end
