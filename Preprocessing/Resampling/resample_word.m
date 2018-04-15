function [newWord] = resample_word(Word, resampleDistance)
%% resample_word
%  Applies Resampling to the Word Struct making all the contiguous points 
%  in Word to have the same constant and fixed distance. To do this
%  the function may remove points that are too close and interpolate points
%  that are too far.
%
% [ _newWord_ ] = _*resample_word*_ ( _Word_ , _resampleDistance_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation.
%
% * *resampleDistance* : Resampling distance in cm.  Default = 0.01cm
%
%%% Outputs
% 
% * *newWord* : A new Word Struct, containing a field Resampled
%                   
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if(nargin < 2)
        resampleDistance = 0.01;
    end

    [ all_segments, ~ ] = segment_by_lost_of_track(Word);
    
    X = [];
    Y = [];
    T = [];
    P = [];
    Al = [];
    Az = [];
    LostOfTrackPoints = [];
    %Apply the Resampling to the data
    [ numSegm , ~ ]=size(all_segments);
    for j=1:numSegm
        
        [iNewSegment] = resample_segment( all_segments(j) , resampleDistance);
    
        X = [X; iNewSegment.X]; 
        Y = [Y; iNewSegment.Y]; 
        T = [T; iNewSegment.T];
        P = [P; iNewSegment.P];
        
        if( j < numSegm)
            LostOfTrackPoints = [LostOfTrackPoints length(X)];
        end
        
        if (isfield(Word,'Az'))
            Az = [Az; iNewSegment.Az];
        end

        if (isfield(Word,'Al'))
            Al = [Al; iNewSegment.Al];
        end
      
    end

    newWord.X = X;
    newWord.Y = Y;
    newWord.T = T;
    newWord.P = P;
    newWord.NumSamples     = length(X);
    newWord.SamplePeriod   = inf;
    newWord.LostOfTrackPoints = LostOfTrackPoints;
    newWord.Tracking     = compute_word_tracking_type(newWord);
       
    if (isfield(Word,'Metadata'))
        newWord.Metadata = Word.Metadata;
    end
    
    if (isfield(Word,'Az'))
        newWord.Az = Az;
    end
    
    if (isfield(Word,'Al'))
        newWord.Al = Al;
    end

end