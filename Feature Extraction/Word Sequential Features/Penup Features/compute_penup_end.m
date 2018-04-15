function [ is_penup_end ] = compute_penup_end(Word)
%% compute_penup_end
%  Computes an array that contains 1 if the observation is the end of 
%  a penup and 0 otherwise.
%
% [ _is_penup_start_ ] = _*compute_penup_end*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *is_penup* : An array that contains 1 if the observation is a penup 
%                end and 0 otherwise.
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    is_penup_end = false(Word.NumSamples,1);
    
    if(strcmp(Word.Tracking,'ON_TABLET_ON_AIR'))
        for k=2:Word.NumSamples
            if((Word.P(k)>0 && Word.P(k-1)==0) )
                is_penup_end(k) = true;
            end
        end
    else if (strcmp(Word.Tracking,'ON_TABLET'))
            is_penup_end(Word.LostOfTrackPoints + 1) = true;
        else
            error('There is no point in computing the penup starts on an ON_AIR Word')
        end
    end
    

end