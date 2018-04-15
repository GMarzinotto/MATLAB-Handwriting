function [all_segments, penup_segments, pendown_segments, separators] = segment_by_penups_pendowns(Word)
%% segment_by_penups_pendowns
%  Takes a Word and produces a list of Word Struct where 
%  each word corresponds to a continuous segment on tablet
%  or a continuous segment on air. These strokes are returned
%  in three lists considering only on tablet, only on air and both.
%  The Criterion for the segmentation in this function is that each stroke 
%  must have a continuous trajectory either on air or on tablet
%  We segment using the penups and pendowns occurences as criterion.
%
% [ _all_segments_ , _penup_segments_ , _pendown_segments_ , _separators_ ] = _*segment_by_penups_pendowns*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *all_segments* : An array of Word Structs as defined in this framework 
%                      considering all possible segments
%
% * *penup_segments*   : An array of Word Structs as defined in this framework 
%                          considering all segments on pen up (on air)
%
% * *pendown_segments* : An array of Word Structs as defined in this framework 
%                          considering all segments on pen down
%
% * *separators* :  A Matrix containing the markers for each segment
%                   the first column contains the initial point of each  
%                   segment and the second colum the final point.
%                   each row stands for a segment. 
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    penup_segments = [];
    pendown_segments = [];
    all_segments = [];
    
    
    singularPoints = find_singular_points(Word);
    %singularPoints(1) = 0; %Small fix for the 1st point
    
    separators = [];

    for k=1:length(singularPoints)-1
        if(singularPoints(k+1) - (singularPoints(k)) > 1)
            
            if( (Word.P(singularPoints(k)) > 0 && Word.P(singularPoints(k)+1) == 0) || (Word.P(singularPoints(k)) == 0 && Word.P(singularPoints(k)+1) > 0) )
                offset = 1;
            else
                offset = 0;
            end
            
            iSegment.X = Word.X(singularPoints(k)+offset:singularPoints(k+1)); 
            iSegment.Y = Word.Y(singularPoints(k)+offset:singularPoints(k+1)); 
            iSegment.P = Word.P(singularPoints(k)+offset:singularPoints(k+1)); 
            iSegment.T = Word.T(singularPoints(k)+offset:singularPoints(k+1)); 
            if (isfield(Word,'Az'))
                iSegment.Az = Word.Az(singularPoints(k)+offset:singularPoints(k+1)); 
            end
            if (isfield(Word,'Al'))
                iSegment.Al = Word.Al(singularPoints(k)+offset:singularPoints(k+1)); 
            end
            iSegment.NumSamples     = length(iSegment.X);
            
            iSegment.SamplePeriod   = Word.SamplePeriod;
            
            iSegment.LostOfTrackPoints  = [];
            iSegment.FileType  = 'STROKE';
            if(sum(iSegment.P == 0) == 0 )
                iSegment.Tracking = 'ON_TABLET';
                pendown_segments = [pendown_segments; iSegment];
            else
                iSegment.Tracking = 'ON_AIR';
                penup_segments = [penup_segments; iSegment];
            end
            all_segments = [all_segments; iSegment];
            separators = [separators; [ (singularPoints(k)+offset) singularPoints(k+1)]];
        end
    end

end