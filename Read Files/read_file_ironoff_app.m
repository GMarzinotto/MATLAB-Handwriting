function [ Word ] = read_file_ironoff_app(path)
%% read_file_ironoff_app
%  Reads a File from the Ironoff
%  And Returns a Struct containing the Word signal and its metadata
%
% [ _Word_ ] = _*read_file_ironoff_app*_ ( _path_ )
%
%%% Inputs
% 
% * *Path*       : The path to the file to read  
%
%%% Outputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (April 2016)
%  Modified by: ---
%%

    % Constants Declaration
    WACOM_RESOLUTION = 300;
    INCH_TO_CM  = 2.54; 
    MSEC_TO_SEC = 10^-3;
    MAX_PRESSURE = 256;
    % Computes the factor to convert from distances in pixel to distances in cm
    % The length of one pixel corresponds to the inverse resolution, which is 
    % then converted from inches to cm.
    PIXEL_TO_CM = INCH_TO_CM/WACOM_RESOLUTION;     %Constant to convert pix => cm


    fid = fopen(path,'r');
    if fid ~= -1
        %First 11 Lines are useless
        for k=1:11
            fgetl(fid);
        end

        ID = fscanf(fid,'.WRITER_ID	%s');
        fgetl(fid);
        country = fscanf(fid,'.COUNTRY %s');
        fgetl(fid);
        hand = fscanf(fid,'.HAND		%s');
        fgetl(fid);
        age = str2num(fscanf(fid,'.AGE		%s'));
        fgetl(fid);
        gender = fscanf(fid,'.SEX		%s');
        fgetl(fid);
        type_f = fscanf(fid,'.SEGMENT %s');
        label  = fscanf(fid,' ? ? "%s"');
        % Label_c = fscanf(fid,'.SEGMENT %s ? ? "%c"');
        fgetl(fid);
        fscanf(fid,'.PEN_DOWN');
        fgetl(fid);    

        data = [];
        while (~feof(fid))
            data = [data; fscanf(fid,'%f %f %f %f', [4,inf])'];   
            fgetl(fid); 
            fgetl(fid); 
        end

        fclose(fid);

        Word.X  = (data(:,1)-mean(data(:,2)))*PIXEL_TO_CM;
        Word.Y  = -1*(data(:,2)-mean(data(:,3)))*PIXEL_TO_CM;
        Word.P  = data(:,3)/MAX_PRESSURE;
        Word.T  = data(:,4)*MSEC_TO_SEC;
        Word.Tracking = 'ON_TABLET'; %Word Contains Only ON_TABLET data
        Word.NumSamples     = length(data(:,1));
        Word.SamplePeriod   = 10*10^-3; %In Seconds
        Word.Label          = label(1:end-1);
        Word.ContentType    = type_f;
        Word.Writer_ID      = ID;
        Word.Metadata.Writer_Country = country;
        Word.Metadata.Writer_Hand    = hand;
        Word.Metadata.Writer_Age     = age; 
        Word.Metadata.Writer_Gender  = gender;
        Word.LostOfTrackPoints       = find_lost_of_track_points(Word);
        [ is_valid , timestamps ] = verify_if_file_is_valid( Word );
        
        %If file is invalid, (it has error in the Time Component)
        if(~is_valid)
            line_indexes = find_line_containing_timestamp_in_ironoff( path , timestamps );
            if(~isempty(line_indexes))
                delete_line_from_file( path , line_indexes );
            end
            Word = read_file_ironoff_app(path);
        end
        
    else
        
        Word = [];
    
    end

end