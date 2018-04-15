function [newWord] = reset_time_word(Word)
%% reset_time_word
%  Resets the time in a Word Struct
%
% [ _newWord_ ] = _*reset_time_word*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *newWord* : A new Word Struct, starting in time T(1)=0; 
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    newWord   = Word;
    newWord.T = newWord.T - newWord.T(1);


end