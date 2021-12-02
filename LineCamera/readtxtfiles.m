function [imu_data,mission_dat,frametime,IOPs,DSM]=readtxtfiles(imufile,missionfile,framefile,DSM_file,settings_file)
%Read the data from the imu file
fidi = fopen(imufile,'rt');
imu_data = cell2mat(textscan( fidi, '%f%f%f%f%f%f%f%f/%f/%f%f:%f:%f%f%f', 'Delimiter',' ','MultipleDelimsAsOne',true,'HeaderLines',1,'CollectOutput', true));
fclose(fidi);

%Read the data about mission from the GPS file
fid = fopen(missionfile,'rt');
mission_dat = cell2mat(textscan(fidi, '%f%f:%f:%f%f%f%f%f%f%f ', 'Delimiter','"', 'MultipleDelimsAsOne',true, 'HeaderLines',1, 'CollectOutput',true));
fclose(fid);
%Read the data about frame time tag from the frame file 
fidi = fopen(framefile,'rt');
frametime = cell2mat(textscan(fidi, '%f %f', 'Delimiter',' ', 'MultipleDelimsAsOne',true, 'HeaderLines',1, 'CollectOutput',true));
fclose(fidi);
%Read the DSM data
[~,DSM]=LASRead(DSM_file);
%DSM=[DSM.x,DSM.y,DSM.z];
%Read the IOPs from the settings file
file_iop = fopen(settings_file);
IOPs = textscan(file_iop, '%s %s %s');
fclose(file_iop);
%Get effective focal length,pixel size and normalized pixel_size
c=str2double(char(IOPs{1,2}(7,1))); %focal lenth in mm
pixel_pitch=str2double(char(IOPs{1,3}(9,1))); %Pixel size in micron
c=c*1000/pixel_pitch; %Focal lenth in pixels
pixel_size=pixel_pitch/pixel_pitch;
IOPs=[c,pixel_pitch,pixel_size];
end