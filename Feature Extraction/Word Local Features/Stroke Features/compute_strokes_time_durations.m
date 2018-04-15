function [ time_durations ] = compute_strokes_time_durations( Word , word_type , stroke_criterion )
%% compute_strokes_time_durations
%  Computes the time durations of all the strokes on the word
%  A stroke is segmented under the definition provided in stroke_criterion.
%  Lengths duration is in seconds
%
% [ _time_durations_ ] = _*compute_strokes_time_durations*_ ( _Word_ , _word_type_ , _stroke_criterion_ )
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
% * *time_duration* : List of time durations to write each segment in Word
%                     durations are given in seconds 
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
    
    
    nSegments = length(all_segments);
    time_durations = zeros(nSegments,1); 

    
    for k=1:nSegments
        duration = compute_word_time_duration(all_segments(k));
        time_durations(k) = duration;
    end
    
    
end