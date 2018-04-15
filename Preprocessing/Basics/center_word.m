function [newWord] = center_word(Word)
%% center_word
%  Recenters the Word Struct
%
% [ _newWord_ ] = _*center_word*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *newWord* : A new Word Struct, centered 
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    newWord = Word;
    newWord.X = newWord.X - mean(newWord.X);
    newWord.Y = newWord.Y - mean(newWord.Y);


end