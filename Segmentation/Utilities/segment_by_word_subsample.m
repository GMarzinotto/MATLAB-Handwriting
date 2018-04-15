function [ newWord ] = segment_by_word_subsample( Word , Samples_idx )
%% segment_by_word_subsample
%  Takes Word and returns a Word Struct that is a subset of Word
%  considering the samples points stored in Samples_idx.
%
% [ _newWord_ ] = _*segment_by_word_subsample*_ ( _Word_ , _Samples_idx_ )
%
%%% Inputs
% 
% * *Word*    : A Word Struct as defined in this framework 
%               see wordStruct documentation. 
%
% * *Samples_idx* : The indexes of the subset of points to put keep in 
%                   the segmented word.
%
%%% Outputs
% 
% * *newWord* : A Word Structs as defined in this framework 
%               considered as a segment between the start and end
%               points given as input.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if(length(Samples_idx) > 2)

        newWord.X = Word.X(Samples_idx);
        newWord.Y = Word.Y(Samples_idx);
        newWord.P = Word.P(Samples_idx);
        newWord.T = Word.T(Samples_idx);

        newWord.SamplePeriod = Word.SamplePeriod;
        newWord.NumSamples   = length(newWord.X);
        newWord.Tracking	 = compute_word_tracking_type(newWord);
        newWord.ContentType  = Word.ContentType;
        
        %New Lost of Track Points are the previous lost of track points that
        %matches, plus the gaps in Sample_idx
        newLostOfTrack = [];
        for k=1:length(Word.LostOfTrackPoints)
            newLostOfTrack = [newLostOfTrack  find( Samples_idx == Word.LostOfTrackPoints(k) )];
        end

        for k=1:length(Samples_idx)-1
            if( Samples_idx(k+1) - Samples_idx(k) > 1)
                newLostOfTrack = [newLostOfTrack  k];
            end
        end

        newLostOfTrack = sort(unique(newLostOfTrack));

        if( ~isempty(newLostOfTrack) && newLostOfTrack(end) == Samples_idx(end) )
            newLostOfTrack(end) = [];
        end

        newWord.LostOfTrackPoints = newLostOfTrack;

        if (isfield(Word,'Metadata'))
            newWord.Metadata = Word.Metadata;
        end

        if (isfield(Word,'Az'))
            newWord.Az = Word.Az(Samples_idx);
        end

        if (isfield(Word,'Al'))
            newWord.Al = Word.Al(Samples_idx);
        end
    
    else   
        error('user provided a list to small to be a word of samples ')
    end

end