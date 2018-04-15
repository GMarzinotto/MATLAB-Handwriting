function [penup_fequency] = compute_penup_fequency(Word)
%% compute_penup_fequency
%  Computes the cocient between number of penups and total number of strokes 
%  passing through the corpus of the word at the average height.
%  To use this feature input must be previously presegmented and Word
%  Must contain only one line on text
%
% [ _penup_fequency_ ] = _*compute_penup_fequency*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *penup_fequency* : cocient between time on air and total time used in writing Word
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

    
    num_penups  = compute_number_of_penups(Word);
    num_strokes = compute_number_of_strokes_passing_through_corpus(Word,'ON_TABLET') + 1;
    
    penup_fequency = num_penups/num_strokes;
    
end