function [lasheader,XYZ] = LASRead (infilename)
%% Function Modified from Philip Glira https://github.com/pglira/Point_cloud_tools_for_Matlab

% LASREAD reads in files in LAS 1.3 and 1.1 format, other formats can be handeled 
% easily by using the details of formatting style and bytes 
% INPUT
% infilename:   Input LAS file name  (for example, 'myinfile.las')
% OUTPUT
% XYZ:      A 1x1 struct contianing the XYZ point cloud,Intensity,return
%           number, number of returns,scan direction flag and edge of the flight
%           line arrays
% 
% EXAMPLE
% A = LASRead ('infile.las')
%

% Open the file
fid =fopen(infilename);

% Check whether the file is valid
if fid == -1
    error('Error opening file')
end

% Read the header to extarct the required information
lasheader=read_las_header(infilename);

if lasheader.version_major == 1 && lasheader.version_minor == 3
    % Solve for the LAS format 1.3
    [X, Y, Z,Int,R,N,S,E]=Read_Raw_Data(fid,infilename,30,269);
else
    %Solve for the LAS format 1.1
    [X, Y, Z,Int,R,N,S,E]=Read_Raw_Data(fid,infilename,24,221);
end

%Read the data from the file


f1='x'; v1=X;
f2='y'; v2=Y;
f3='z'; v3=Z;
f4='intensity'; v4=Int;
f5='return_number'; v5=R;
f6='number_of_returns'; v6=N;
f7='scan_direction_flag'; v7=S;
f8='edge_of_flight_line'; v8=E;

XYZ=struct(f1,v1,f2,v2,f3,v3,f4,v4,f5,v5,f6,v6,f7,v7,f8,v8);
fclose (fid);
end
