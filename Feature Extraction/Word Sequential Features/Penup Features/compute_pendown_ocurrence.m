function [ is_pendown ] = compute_pendown_ocurrence(Word)
%% compute_pendown_ocurrence
%  Computes an array that contains 0 if the observation is a penup 
%  and 1 otherwise.
%
% [ _is_pendown_ ] = _*compute_pendown_ocurrence*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *is_pendown* : An array that contains 0 if the observation is a penup 
%                  and 1 otherwise.
%                   
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    is_pendown = true(Word.NumSamples,1);
    is_pendown(Word.P==0) = false;


end