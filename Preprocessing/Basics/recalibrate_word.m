function [newWord] = recalibrate_word(Word)
%% recalibrate_word
%  Recenters the Word Struct, and resets the initial time point to cero.
%
% [ _newWord_ ] = _*recalibrate_word*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *newWord* : A new Word Struct, centered and with time reset to cero
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    newWord = Word;
    newWord = reset_time_word(newWord);
    newWord = center_word(newWord);


end