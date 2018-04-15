function [singularPoints] = find_lost_gain_of_track_points(Word)
%% find_lost_gain_of_track_points
% Create a List of the Lost/Gain of track Points
% A Lost/Gain of track Point is a point that fills at least one of the following:
% 1) Is the start point
% 2) Is the end point
% 3) Is a Point where the tablet losses track of the pen
% 4) Is a Point where the tablet regains track of the pen
%
% [ _singularPoints_ ] = _*find_lost_gain_of_track_points*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *singularPoints* : A List of the index of the singular points in Word
%


    singularPoints = 1;
    
    for j=1:Word.NumSamples-1
        if (Word.T(j+1)-Word.T(j)>3*Word.SamplePeriod)
            singularPoints = [singularPoints j j+1];
        end
    end
    
    singularPoints = [singularPoints Word.NumSamples];
    
end