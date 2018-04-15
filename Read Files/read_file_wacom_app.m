function [ Word ] = read_file_wacom_app(path)
%% read_file_wacom_app
%  Reads a File from the Wacom Application Protocol
%  And Returns a Struct containing the Word signal and its metadata
%
% [ _Word_ ] = _*read_file_wacom_app*_ ( _path_ )
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
    WACOM_RESOLUTION = 5080;
    INCH_TO_CM  = 2.54; 
    MSEC_TO_SEC = 10^-3;
    MAX_PRESSURE = 1024;
    % Computes the factor to convert from distances in pixel to distances in cm
    % The length of one pixel corresponds to the inverse resolution, which is 
    % then converted from inches to cm.
    PIXEL_TO_CM = INCH_TO_CM/WACOM_RESOLUTION;     %Constant to convert pix => cm


    fid = fopen(path,'r');

    for k=1:22
        fgetl(fid);
    end

    data = fscanf(fid,'%f %f %f %f %f %f', [6,inf])';    
    fclose(fid);

    data(end-3:end,:) = [];

    Word.T  = data(:,1)*MSEC_TO_SEC;
    Word.X  = (data(:,2)-mean(data(:,2)))*PIXEL_TO_CM;
    Word.Y  = -1*(data(:,3)-mean(data(:,3)))*PIXEL_TO_CM;
    Word.P  = data(:,4)/MAX_PRESSURE;
    Word.Az = data(:,5)/10;
    Word.Al = data(:,6)/10;
    Word.NumSamples    = length(data(:,1));
    Word.SamplePeriod  = 8*10^-3; %In Seconds
    Word.ContentType = 'FULL_TEXT';  %TODO: Modify to consider graphic tests
    Word.Tracking = compute_word_tracking_type(Word);
    Word.LostOfTrackPoints = find_lost_of_track_points(Word);
    [ is_valid , timestamps ] = verify_if_file_is_valid( Word );


    %If file is invalid, (it has error in the Time Component)
    if(~is_valid)
         line_indexes = find_line_containing_timestamp_in_wacom( path , timestamps );
         if(~isempty(line_indexes))
             delete_line_from_file( path , line_indexes );
         end
         Word = read_file_ironoff_app(path);
    end

end