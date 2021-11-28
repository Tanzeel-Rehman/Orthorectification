function [X, Y, Z,Int,Rnum,NumReturns,scanflag,edge]=Read_Raw_Data(fid,infilename,XYZbytes,Rbits)

%% Function Modified from Philip Glira https://github.com/pglira/Point_cloud_tools_for_Matlab
%% INPUT:                                                                
% fid: An open file identifier
% infilename: Input LAS file name  (for example, 'myinfile.las')
% XYZbytes: The number of bytes to skip as per the LAS version
% Rbits: The number of bits to skip as per the LAS version
%                                                                        
%% OUTPUT:                                                               
% [X,y,Z,Int,Rnum,NumReturns,scanflag,edge]: An array containing X,Y,Z,Intensity 
%and return number for all the points. It also provides the number of returns for 
%the perticular pulse, scanflagdirection and the edge ingormation of the
%flight.

%Read the information from LAS header file 
lasheader=read_las_header(infilename);
%Determine the location containing the data with reference to the begining of the file (offset) 
c=lasheader.offset_to_point_data;

%Read in the Y coordinates of the points
fseek(fid, c, 'bof');
X1=fread(fid,inf,'long',XYZbytes); %30 bytes to skip as per version 1.3
%Convert to the real world coordinates based on the LAS formatting standard
X=(X1*lasheader.x_scale_factor)+lasheader.x_offset;

% Read in the Y coordinates of the points
fseek(fid, c+4, 'bof');
Y1=fread(fid,inf,'long',XYZbytes);
Y=(Y1*lasheader.y_scale_factor)+lasheader.y_offset;

% Read in the Z coordinates of the points
fseek(fid, c+8, 'bof');
Z1=fread(fid,inf,'long',XYZbytes);
Z=(Z1*lasheader.z_scale_factor)+lasheader.z_offset; %Convert the coordinates

% Read in the Intensity values of the points
fseek(fid, c+12, 'bof');
Int=fread(fid,inf,'uint16',XYZbytes+2);

% Read in the Return Number of the points. The first return will have a
% return number of one, the second, two, etc.
fseek(fid, c+14, 'bof');
Rnum=fread(fid,inf,'bit3',Rbits); %Skip 269 bits as per version 1.3

% Read in the Number of Returns for a given pulse.
fseek(fid, c+14, 'bof');
fread(fid,1,'bit3');
NumReturns=fread(fid,inf,'bit3',Rbits);
% Read in the scan direction flag
fseek(fid, c+14, 'bof');
fread(fid,1,'bit1');
scanflag=fread(fid,inf,'bit1',Rbits+2);
% Read in the edge of flight line information
fseek(fid, c+14, 'bof');
fread(fid,1,'bit1');
edge=fread(fid,inf,'bit1',Rbits+2);
end
