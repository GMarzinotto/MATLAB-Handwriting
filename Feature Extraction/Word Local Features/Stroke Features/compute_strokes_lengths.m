function [ stroke_lengths_modules, stroke_lengths_x, stroke_lengths_y ] = compute_strokes_lengths( Word , word_type , stroke_criterion )
%% compute_strokes_lengths
%  Computes the lengths of all the strokes on the word
%  A stroke is segmented under the definition provided in stroke_criterion.
%  Lengths computed include the length of the X projection,
%  of the Y projection and the module.
%
% [ _stroke_lengths_module_ , _stroke_lengths_x_ , _stroke_lengths_y_ ] = _*compute_strokes_lengths*_ ( _Word_ , _word_type_ , _stroke_criterion_ )
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
% * *stroke_length_modules* : List of lengths in cm of the total trajectory of Word module
%
% * *stroke_length_x* : List of lengths in cm of the X projection of the Word trajectory 
%
% * *stroke_length_y* : List of lengths in cm of the Y projection of the Word trajectory 
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if(~isempty(Word))

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
        stroke_lengths_modules = zeros(nSegments,1); 
        stroke_lengths_x = zeros(nSegments,1); 
        stroke_lengths_y = zeros(nSegments,1); 

        for k=1:nSegments
            [ length_module, length_x, length_y ] = compute_word_lengths(all_segments(k));
            stroke_lengths_modules(k) = length_module;
            stroke_lengths_x(k) = length_x;
            stroke_lengths_y(k) = length_y;
        end
    
    else
        
        stroke_lengths_modules  = [];
        stroke_lengths_x        = [];
        stroke_lengths_y        = [];
        
    end
    
end