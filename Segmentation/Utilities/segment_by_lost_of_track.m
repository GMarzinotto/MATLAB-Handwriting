function [all_segments, separators] = segment_by_lost_of_track(Word)
%% segment_by_lost_of_track
%  Takes a Word and produces a list of Word Struct where 
%  each word corresponds to a continuous segment. 
%  A continuous segment means a segment where we don't lose track of the
%  pen, it can be a segment ON_TABLET , ON_AIR or ON_TABLET_ON_AIR. 
%  Lost of track means that we do not register points.
%  A lost of track is triger whenever T(n+1) - T(n) > 3*SamplingPeriod
%  These strokes are returned on a list of Word Elements, as well as
%  a list of the separators. 
%
% [ _all_segments_ , _separators_ ] = _*segment_by_lost_of_track*_ ( _Word_ )
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
    
    
    singularPoints = find_lost_gain_of_track_points(Word);
    singularPoints(1) = 0; %Small fix for the 1st point
    
    separators = zeros(length(singularPoints)-1,2);
    
    for k=1:length(singularPoints)-1
        if(singularPoints(k+1) - (singularPoints(k)+1) > 1)
            separators(k,:) = [singularPoints(k)+1 singularPoints(k+1)];
            iSegment   = Word;
            iSegment.X = Word.X(singularPoints(k)+1:singularPoints(k+1)); 
            iSegment.Y = Word.Y(singularPoints(k)+1:singularPoints(k+1)); 
            iSegment.P = Word.P(singularPoints(k)+1:singularPoints(k+1)); 
            iSegment.T = Word.T(singularPoints(k)+1:singularPoints(k+1)); 
            if (isfield(Word,'Az'))
                iSegment.Az = Word.Az(singularPoints(k)+1:singularPoints(k+1)); 
            end
            if (isfield(Word,'Al'))
                iSegment.Al = Word.Al(singularPoints(k)+1:singularPoints(k+1)); 
            end
            iSegment.NumSamples  = length(iSegment.X);
            if(sum(iSegment.P)==0)
                iSegment.Tracking = 'ON_AIR';
                penup_segments = [penup_segments; iSegment];
            else
                iSegment.Tracking = 'ON_TABLET';
                pendown_segments = [pendown_segments; iSegment];
            end
            all_segments = [all_segments; iSegment];
        end
    end

end