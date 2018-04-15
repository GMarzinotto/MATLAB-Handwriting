function [newWord] = filter_word(Word , Filter)
%% filter_word
%  Applies Filtering to the Word Struct. Convolutional filter coefficients
%  must be provided as input through a Filter Object.
%
% [ _newWord_ ] = _*filter_word*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
% * *Filter* : A Filter Object to be applied to Word.
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
       
% TODO: Stop filtering the Time Component and compute Time appropriately
%       The filter collapses the Word struct if you re apply it many times

    [ all_segments, ~ ] = segment_by_lost_of_track(Word);
    
    X = [];
    Y = [];
    T = [];
    P = [];
    Al = [];
    Az = [];
    LostOfTrackPoints = [];
    %Apply the Filter to the data
    [ numSegm , ~ ]=size(all_segments);
    for j=1:numSegm
        
        x_fil = Filter.filter_data(all_segments(j).X);
        y_fil = Filter.filter_data(all_segments(j).Y);
        t_fil = Filter.filter_data(all_segments(j).T);
        p_fil = all_segments(j).P;

        p_fil([1:(Filter.Number_Of_Coefficients)/2]) = [];
        p_fil([end-((Filter.Number_Of_Coefficients-1)/2 - 1):end]) = [];
    
        X = [X; x_fil]; 
        Y = [Y; y_fil]; 
        T = [T; t_fil];
        P = [P; p_fil];
        
        if( j < numSegm)
            LostOfTrackPoints = [LostOfTrackPoints length(X)];
        end
        
        
        if (isfield(Word,'Az'))
            az_fil = Filter.filter_data(all_segments(j).Az);
            Az = [Az; az_fil];
        end

        if (isfield(Word,'Al'))
            al_fil = Filter.filter_data(all_segments(j).Al);
            Al = [Al; al_fil];
        end
      
    end

    newWord.X = X;
    newWord.Y = Y;
    newWord.T = T;
    newWord.P = P;
    newWord.NumSamples   = length(X);
    newWord.SamplePeriod = Word.SamplePeriod;
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

    newWord = center_word(newWord);
    
end