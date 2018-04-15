function [ num_strokes ] = compute_number_of_strokes( Word , word_type , stroke_criterion )
%% compute_number_of_strokes
%  Counts the number of strokes in the Word.
%
% [ _num_strokes_ ] = _*compute_number_of_strokes*_ ( _Word_ , _word_type_ , _stroke_criterion_ )
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
% * *num_strokes* : Number of penup strokes in the Word.
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    if(strcmp(stroke_criterion,'PENUP_CRITERION'))
        [all_segments, ~, ~, ~] = segment_by_penups_pendowns(iWord);
    else
        if (strcmp(stroke_criterion,'VY_CRITERION'))
            [all_segments, ~, ~, ~] = segment_by_strokes_vy_criterion(iWord);
        else
            if (strcmp(stroke_criterion,'VX_CRITERION'))
                [all_segments, ~, ~, ~] = segment_by_strokes_vx_criterion(iWord);
            else
                if (strcmp(stroke_criterion,'VX_VY_CRITERION'))
                    [all_segments, ~, ~, ~] = segment_by_strokes_vx_vy_criterion(iWord);
                else
                    error('Invalid Stroke Criterion! Must be one of the 4 options: PENUP_CRITERION , VY_CRITERION , VX_CRITERION or VX_VY_CRITERION')
                end
            end
        end
    end
    
    num_strokes = length(all_segments);

   
end