function [ word_on_air ] = discard_pendown_tracking_information(Word)
%% discard_pendown_tracking_information
%  Produces a new Word Struct where the information of the pendown
%  tracking on tablet is discarted.
%
% [ _word_on_air_ ] = _*discard_pendown_tracking_information*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *word_on_air* : A Word Struct as defined in this framework 
%                   see wordStruct documentation. without the points
%                   where P>0
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%


    if(strcmp(Word.Tracking,'ON_TABLET_ON_AIR'))
        word_on_air   = Word;
        word_on_air.X = Word.X(Word.P==0);
        word_on_air.Y = Word.Y(Word.P==0);
        word_on_air.P = Word.P(Word.P==0);
        word_on_air.T = Word.T(Word.P==0);
        if (isfield(word_on_air,'Az'))
            word_on_air.Az = Word.Az(Word.P==0);
        end
        if (isfield(word_on_air,'Al'))
            word_on_air.Al = Word.Al(Word.P==0);
        end

        %Find the new LostOfTrackPoints
        point = 0;
        LostOfTrackPoints = [];
        for k=1:Word.NumSamples-1
            if(Word.P(k)==0)
        
        
        
                point = point + 1;
                if( Word.P(k+1)>0 || ( ~isempty(Word.LostOfTrackPoints) && any(Word.LostOfTrackPoints == k) ) )
                    LostOfTrackPoints = [LostOfTrackPoints point];
                end
            end
        end
        if(~isempty(LostOfTrackPoints) && Word.P(end)>0 )
            LostOfTrackPoints(end) = [];
        end
        
        word_on_air.LostOfTrackPoints = LostOfTrackPoints;
        word_on_air.NumSamples        = length(word_on_air.X);
        word_on_air.Tracking = 'ON_AIR';
    else
        if(strcmp(Word.Tracking,'ON_TABLET'))
            word_on_air   = [];
            warning(['In discard_pendown_tracking_information: The Input must be a word that tracks on_air and on_tablet movements.' ...
                     'Current Word contains only on_tablet movements, therefore, it returns an empty matrix']);
        end
        if(strcmp(Word.Tracking,'ON_AIR'))
            word_on_air   = Word;
            warning(['In discard_pendown_tracking_information: The Input must be a word that tracks on_air and on_tablet movements.' ...
                     'Current Word contains only on_air movements, therefore, no change was done']);
        end
    end
    
end