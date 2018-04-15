function [ segment ] = segment_using_separators( Word, start_point , end_point )
%% segment_using_separators
%  Takes Word and returns a Word Struct that is a subset of Word
%  starting in start_point and ending in end_point.
%
% [ _segment_ ] = _*segment_using_separators*_ ( _Word_ , _start_point_ , _end_point_ )
%
%%% Inputs
% 
% * *Word*    : A Word Struct as defined in this framework 
%               see wordStruct documentation. 
%
%%% Outputs
% 
% * *segment* : A Word Structs as defined in this framework 
%               considered as a segment between the start and end
%               points given as input.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    
    segment.X = Word.X(start_point:end_point);
    segment.Y = Word.Y(start_point:end_point);
    segment.T = Word.T(start_point:end_point);
    segment.P = Word.P(start_point:end_point);

    if (isfield(Word,'Az'))
        segment.Az = Word.Az(start_point:end_point);
    end
    if (isfield(Word,'Al'))
        segment.Al = Word.Al(start_point:end_point);
    end

    segment.NumSamples   = end_point - start_point + 1;
    segment.SamplePeriod = Word.SamplePeriod;
    segment.LostOfTrackPoints = Word.LostOfTrackPoints( Word.LostOfTrackPoints >= start_point & Word.LostOfTrackPoints <= end_point ) - start_point + 1;
    if( ~isempty(segment.LostOfTrackPoints) && segment.LostOfTrackPoints(end) == segment.NumSamples )
        segment.LostOfTrackPoints(end) = [];
    end
    if( ~isempty(segment.LostOfTrackPoints) && segment.LostOfTrackPoints(1) == 1 )
        segment.LostOfTrackPoints(1) = [];
    end
    
    if (isfield(Word,'Metadata'))
        segment.Metadata = Word.Metadata;
    end
    
    segment.Tracking = compute_word_tracking_type(segment);
    
    
end