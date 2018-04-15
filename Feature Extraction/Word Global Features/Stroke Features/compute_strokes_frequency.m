function [ stroke_freq ] = compute_strokes_frequency( Word , word_type , stroke_criterion )
%% compute_penup_strokes_frequency
%  Counts the frequency of strokes in the Word.
%  Normalized by the total number of strokes 
%  passing through the corpus of the word at the average height.
%
% [ _stroke_freq_ ] = _*compute_penup_strokes_frequency*_ ( _Word_ , _word_type_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
% * *stroke_criterion* : Stroke Segmentation Criterion, options are:
%                        'PENUP_CRITERION' , 'VY_CRITERION' , 
%                        'VX_CRITERION' , 'VX_VY_CRITERION'
%
%%% Outputs
% 
% * *stroke_freq* : Frequency of penup strokes in the Word.
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    num_penups     = compute_number_of_strokes ( iWord , word_type , stroke_criterion );
    strokes_corpus = compute_number_of_strokes_passing_through_corpus( iWord , word_type );
    
    stroke_freq = num_penups/strokes_corpus;

   
end