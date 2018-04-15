function [ newWord ] = convert_word_to_a_new_tracking_type(Word,word_type)
%% convert_word_to_a_new_tracking_type
%  Converts a word struct into a new one that has the word tracing type 
%  provided . It can be used to discard the ON_AIR or the ON_TABLET info.
%  
% [ _newWord_ ] = _*convert_word_to_a_new_tracking_type*_ ( _Word_ , _word_type_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
%%% Outputs
% 
% * *newWord* : A Word Struct as defined in this framework belonging to 
%               the type stablished in the input
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    if(strcmp(word_type,'ON_AIR'))
        if(~strcmp(Word.Tracking,'ON_AIR'))
            newWord  = discard_pendown_tracking_information(Word);
        else
            newWord = Word;
        end
    else
        if(strcmp(word_type,'ON_TABLET'))
            if(~strcmp(Word.Tracking,'ON_TABLET'))
                newWord = discard_penup_tracking_information(Word);
            else
                newWord = Word;
            end
        else if(strcmp(word_type,'ON_TABLET_ON_AIR'))
                newWord = Word;
            else
                word_type
                error( 'convert_word_to_type: Invalid type Input: ' )
            end
        end
    end

end