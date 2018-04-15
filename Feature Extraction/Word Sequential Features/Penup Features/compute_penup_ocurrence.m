function [ is_penup ] = compute_penup_ocurrence(Word)
%% compute_penup_ocurrence
%  Computes an array that contains 1 if the observation is a penup 
%  and 0 otherwise.
%
% [ _is_penup_ ] = _*compute_penup_ocurrence*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *is_penup* : An array that contains 1 if the observation is a penup 
%                and 0 otherwise.
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    is_penup = false(Word.NumSamples,1);
    is_penup(Word.P==0) = true;


end