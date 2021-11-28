function lasHeaderInfo = read_las_header(lasFilename)
%% Function Modified from Philip Glira https://github.com/pglira/Point_cloud_tools_for_Matlab

%% INPUT:                                                                
%lasFilename: Path and filename of LAS file(for example,'myinfile.las')
%                                                                        
%% OUTPUT:                                                               
%lasHeaderInfo:  A 1x1 struct contianing the information extracted from the
%                LAS file header

 
% Open the LAS file
fid=fopen(lasFilename);
if fid == -1 
    error('LAS file could not be opened; check filename and path.')
end

% Read the header info. Numeric data is always read in as a double because 
% built-in MATLAB funtions typically expect doubles.
f1='file_signature'; v1=sscanf(char(fread(fid,4,'char*1=>char*1')'),'%c');
f2='file_Source_ID'; v2=fread(fid,1,'uint16=>double');
f3='global_encoding'; v3=fread(fid,1,'uint16=>double');
f4='project_ID_GUID_data_1'; v4=fread(fid,1,'uint32=>double');
f5='project_ID_GUID_data_2'; v5=fread(fid,1,'uint16=>double');
f6= 'project_ID_GUID_data_3'; v6=fread(fid,1,'uint16=>double');
f7= 'project_ID_GUID_data_4'; v7=fread(fid,8,'uint8=>double')';
f8= 'version_major'; v8=fread(fid,1,'uint8=>double');
f9= 'version_minor'; v9=fread(fid,1,'uint8=>double');
f10= 'system_identifier'; v10=cell2mat(cellstr(sscanf(char(fread(fid,32)'),'%c')));
f11= 'generating_software'; v11=cell2mat(cellstr(sscanf(char(fread(fid,32)'),'%c')));
f12='file_creation_day'; v12=fread(fid,1,'uint16=>double');
f13='file_creation_year'; v13=fread(fid,1,'uint16=>double');
f14='header_size'; v14= fread(fid,1,'uint16=>double');
f15='offset_to_point_data'; v15= fread(fid,1,'uint32=>double');
f16='number_of_variable_length_records'; v16= fread(fid,1,'uint32=>double');
f17='point_data_format'; v17= fread(fid,1,'uint8=>double');
f18='point_data_record_length'; v18= fread(fid,1,'uint16=>double');
f19='number_of_point_records'; v19= fread(fid,1,'uint32=>double');
f20='number_of_points_by_return'; v20= fread(fid,5,'uint32=>double')';
f21='x_scale_factor'; v21= fread(fid,1,'double=>double');
f22='y_scale_factor'; v22= fread(fid,1,'double=>double');
f23='z_scale_factor'; v23= fread(fid,1,'double=>double');
f24='x_offset'; v24= fread(fid,1,'double=>double');
f25='y_offset'; v25= fread(fid,1,'double=>double');
f26='z_offset'; v26= fread(fid,1,'double=>double');
f27='max_x'; v27= fread(fid,1,'double=>double');
f28='min_x'; v28= fread(fid,1,'double=>double');
f29='max_y'; v29= fread(fid,1,'double=>double');
f30='min_y'; v30= fread(fid,1,'double=>double');
f31='max_z'; v31= fread(fid,1,'double=>double');
f32='min_z'; v32= fread(fid,1,'double=>double');

%Create the struct of the data
lasHeaderInfo=struct(f1,v1,f2,v2,f3,v3,f4,v4,f5,v5,f6,v6,f7,v7,f8,v8,f9,v9,f10,v10,f11,v11,f12,v12,f13,v13,...
    f14,v14,f15,v15,f16,v16,f17,v17,f18,v18,f19,v19,f20,v20,f21,v21,f22,v22,f23,v23,f24,v24,f25,v25,...
    f26,v26,f27,v27,f28,v28,f29,v29,f30,v30,f31,v31,f32,v32);
% Close the LAS file
fclose(fid);
end

