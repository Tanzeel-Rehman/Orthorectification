function [x_new,y_new]=Pixelcoordinates(x,y,img,IOPs)
%% Inputs:
% [x,y]: Image coordinates extracted from the collinearity equations
% img: img: A digtial image which need to be rectified
% IOPs: 1x11 vector of the IOPs = [ xp, yp, c,k1,k2,k3,p1,p2,p3,x_pixel_size,y_pixel_size]
%% Output: 
% [x_new,y_new]: The new coordinates converted from the image coordinates
% to pixel coordinate system
x_pixel_size=IOPs(1,10); y_pixel_size=IOPs(1,11);

[nr,nc,~]=size(img);
y_new=(x/x_pixel_size)+(nc/2.0);
x_new=(nr/2.0)-(y/y_pixel_size);
end