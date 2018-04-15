function [penup_number] = compute_number_of_penups(Word)
%% compute_number_of_penups
%  Computes the total number of penups of the word.
%
% [ _penup_number_ ] = _*compute_number_of_penups*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *penup_number* :  number of penups of the word
% 
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    if(~strcmp(Word.Tracking,'ON_TABLET'))
        Word = discard_penup_tracking_information(Word);
    end
   
    penup_number  = length(Word.LostOfTrackPoints);

    
end