function [singularPoints] = find_singular_points(Word)
%% find_singular_points
% Create a List of the Singular Points
% A Singular Point is a point that fills at least one of the following:
% 1) Is the start point
% 2) Is the end point
% 3) Is a Penup Point
% 4) Is a Pendown Point
% 5) Is a Point where the tablet losses track of the pen
% 6) Is a Point where the tablet regains track of the pen
%
% [ _singularPoints_ ] = _*find_singular_points*_ ( _Word_ )
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
        if (Word.P(j)==0 && Word.P(j+1)>0)||(Word.P(j)>0 && Word.P(j+1)==0)
            singularPoints = [singularPoints j];
        else if ( ~isfield(Word,'LostOfTrackPoints') && (Word.T(j+1)-Word.T(j)>3*Word.SamplePeriod))
                singularPoints = [singularPoints j j+1];
                %singularPoints = [singularPoints j];
            end
        end
    end
    
    if(isfield(Word,'LostOfTrackPoints') && ~isempty(Word.LostOfTrackPoints) )
        singularPoints = [singularPoints Word.LostOfTrackPoints (Word.LostOfTrackPoints + 1)];
        %singularPoints = [singularPoints Word.LostOfTrackPoints];
    end
    
    singularPoints = sort(singularPoints);
    singularPoints = [singularPoints Word.NumSamples];
    singularPoints = unique(singularPoints);
    
end