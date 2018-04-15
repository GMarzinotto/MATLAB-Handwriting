function [ is_penup_start ] = compute_penup_start(Word)
%% compute_penup_start
%  Computes an array that contains 1 if the observation is the start of 
%  a penup and 0 otherwise.
%
% [ _is_penup_start_ ] = _*compute_penup_start*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *is_penup* : An array that contains 1 if the observation is a penup 
%                start and 0 otherwise.
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    is_penup_start = false(Word.NumSamples,1);
    
    if(strcmp(Word.Tracking,'ON_TABLET_ON_AIR'))
        for k=1:Word.NumSamples-1
            if((Word.P(k)>0 && Word.P(k+1)==0))
                is_penup_start(k) = true;
            end
        end
    else if (strcmp(Word.Tracking,'ON_TABLET'))
            is_penup_start(Word.LostOfTrackPoints) = true;
        else
            error('There is no point in computing the penup starts on an ON_AIR Word')
        end
    end

end