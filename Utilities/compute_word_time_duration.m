function [ time_duration ] = compute_word_time_duration(Word)
%% compute_word_time_duration
%  Computes Time used to write the Word Struct Content in seconds.
%
% [ _time_duration_ ] = _*compute_word_time_duration*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *time_duration* : Time used to write the Word Struct Content in seconds 
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

   time_duration = Word.T(end) - Word.T(1);
   

   
end