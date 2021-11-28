function [EOP,IOP] = Files_Reader(image_id)
%% inputs: 
%      image_id: A string represnting the image whose EOPs and
%      Imagecoordinates needs to be extracted
%% ouputs:  Returned Initial_EOPs, IOP, GCP and ImageCoordinate Files

%% --------------Reading EOP File----------------
%read EOPs
% Set the format to be long to avoid the rounding
format long;
[eop_file,pathname] = uigetfile({'*.txt'},'Please Select EOP file(eop.txt)');
%Get the EOP file
eop_file = strcat(pathname,eop_file);
fin_eop = fopen(eop_file);
%Get an array of n x 7 EOPs (ImageID, Omega,Phi,Kappa, X, Y,and Z).Where n is number of images   
eop = cell2mat(textscan(fin_eop,'%f %f %f %f %f %f %f'));
% Close the file reader
fclose(fin_eop);
% Return the EOPs of all the Images
EOP=eop;
%EOPs of only specific image
%index=find(eop==image_id);
%EOP=eop(index,2:end);
%%  ---------------Reading the IOPs File--------------------------
% [IOP_file,pathname_iop] = uigetfile({'*.txt'}, 'Please select IOP file');
% IOP_file = strcat(pathname_iop, IOP_file);
% file_iop = fopen(IOP_file);
% iops = textscan(file_iop, '%s %s %s');
% %Get the IOP parameters
% parameters=str2num(char(iops{1,3}));
% xp=parameters(1);  yp= parameters(2);  c=parameters(3);   k1= parameters(4);
% k2=parameters(5);  k3= parameters(6);  p1=parameters(7);  p2= parameters(8);
% p3=parameters(9);
% IOPs= [xp,yp,c,k1,k2,k3,p1,p2,p3];
% fclose(file_iop);
% %Return the IOPs
% IOP=IOPs;

%%  ---------------Reading the IOPs File _Format_2--------------------------
[IOP_file,pathname_iop] = uigetfile({'*.txt'}, 'Please select IOP file');
IOP_file = strcat(pathname_iop, IOP_file);
file_iop = fopen(IOP_file);
iops = textscan(file_iop, '%f %f %f');
%Get the IOP parameters
xp=iops{1,1}(5,1); yp=iops{1,2}(5,1); c=iops{1,3}(5,1);
k1=iops{1,1}(6,1); k2=iops{1,1}(7,1); k3=iops{1,1}(8,1);
p1=iops{1,1}(9,1); p2=iops{1,1}(10,1); p3=iops{1,1}(11,1);
x_pixel_size=iops{1,1}(3,1); y_pixel_size=iops{1,2}(3,1);

IOPs= [xp,yp,c,k1,k2,k3,p1,p2,p3,x_pixel_size,y_pixel_size];
fclose(file_iop);
%Return the IOPs
IOP=IOPs;
