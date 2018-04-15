function [ Writer ] = read_full_person_wacom_app(path)
%% read_file_wacom_app
%  Reads a File from the Wacom Application Protocol
%  And Returns a Struct containing the Word signal and its metadata
%
% [ _Word_ ] = _*read_file_wacom_app*_ ( _path_ )
%
%%% Inputs
% 
% * *Path*       : The path to the folder of the person to read  
%
%%% Outputs
% 
% * *Writer*      : A Writer Struct as defined in this framework 
%                   see wordStruct documentation.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%



    file_info = fopen(strcat(path,'\Info.txt'),'r');

    if file_info ~= -1
        
        fgetl(file_info);
        ID = fscanf(file_info,'Firstname: %s');
        fgetl(file_info);
        age = str2num(fscanf(file_info,'Age: %s'));
        fgetl(file_info);
        gender = fscanf(file_info,'Gender: %s');
        fgetl(file_info);
        hand = fscanf(file_info,'Hand: %s');
        fclose(file_info);

        Writer.Test1 = read_file_wacom_app(strcat(path,'\Test1.txt'));

        Writer.Metadata.Writer_ID      = ID;
        Writer.Metadata.Writer_Hand    = hand;
        Writer.Metadata.Writer_Age     = age; 
        Writer.Metadata.Writer_Gender  = gender;

    else
        error('Verify Path')
    end

end
