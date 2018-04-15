function [ horizontal_length , vertical_length ] = compute_word_horizontal_and_vertical_lengths( Word )
%% compute_word_horizontal_and_vertical_lengths
%  Computes the horizontal length of the given Word. 
%  the length is computed as the espace between the  
%  percentils 5% and 95% of the X coordinates values. 
%
% [ _horizontal_length_ , _vertical_length_ ] = _*compute_word_horizontal_and_vertical_lengths*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*    : A Word Struct as defined in this framework 
%               see wordStruct documentation. 
%
%
%%% Outputs
% 
% * *horizontal_length* : horizontal length of the word in centimeters
%
% * *vertical_length*   : vertical length of the word in centimeters
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%


    if(~strcmp(Word.Tracking,'ON_TABLET'))
        Word = discard_penup_tracking_information(Word);
    end
    
    percentils_5_95   = prctile(Word.X,[5 95]);
    horizontal_length = percentils_5_95(end) - percentils_5_95(1);
    
    percentils_5_95   = prctile(Word.Y,[5 95]);
    vertical_length   = percentils_5_95(end) - percentils_5_95(1);

end