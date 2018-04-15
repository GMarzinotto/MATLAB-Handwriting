function [singularPoints] = find_lost_of_track_points(Word)
%% find_lost_of_track_points
% Create a List of the Lost of track Points
% A Lost of track Point is a point that fills at least one of the following:
% 1) Is a Point where the tablet losses track of the pen
%
% [ _singularPoints_ ] = _*find_lost_of_track_points*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *singularPoints* : A List of the index of the singular points in Word.
%

    singularPoints = [ ];
    
    for j=1:Word.NumSamples-1
        if (Word.T(j+1)-Word.T(j)>5*Word.SamplePeriod)
            singularPoints = [singularPoints j];
        end
    end
      
end