function [ Stroke_TimeDuration ] = compute_stroke_time_duration_unidimensional_statistics( Word , word_type , stroke_criterion )
%% compute_stroke_time_duration_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on penup stroke
%  time durations. Mean, Std, Min, Max, Range, Percentils (steps of 5%)
%  user must also provide an input specifiying which strokes should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Stroke_TimeDuration_ ] = _*compute_stroke_time_duration_unidimensional_statistics*_ ( _Word_ , _word_type_ , _stroke_criterion_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
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
% * *Stroke_TimeDuration*  : A struct containing all the parameters, organized first in
%                            the norm used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    strokes_time_durations = compute_strokes_time_durations(iWord,word_type,stroke_criterion);

    [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , skew_kurt ] = compute_unidimensional_statistics(strokes_time_durations);    

    Stroke_TimeDuration.mean       = avg_val;
    Stroke_TimeDuration.std        = std_val;
    Stroke_TimeDuration.min        = min_val;
    Stroke_TimeDuration.max        = max_val;
    Stroke_TimeDuration.range      = ran_val;
    Stroke_TimeDuration.percentils = per_val;
    Stroke_TimeDuration.skewness   = skew_val;
    Stroke_TimeDuration.kurtosis   = skew_kurt;
   
    
end