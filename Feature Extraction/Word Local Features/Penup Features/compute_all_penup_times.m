function [ penup_times ] = compute_all_penup_times(Word)
%% compute_all_penup_times
%  Computes an array that contains all the penup times in Word.
%
% [ _penup_times_ ] = _*compute_all_penup_times*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *penup_times* : An array that contains all the penup times in Word
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%


    if(~strcmp(Word.Tracking,'ON_TABLET'))
        Word = discard_penup_tracking_information(Word);
    end

    dTime = diff(Word.T);
    penup_times = dTime(Word.LostOfTrackPoints);
    
    
end