function [ Stroke_Length ] = compute_stroke_length_unidimensional_statistics( Word , word_type , stroke_criterion )
%% compute_stroke_length_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on strokes
%  lengths. Mean, Std, Min, Max, Range, Percentils (steps of 5%)
%  this is done using the L2 norms and raw values 
%  user must also provide an input specifiying which strokes should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Stroke_Length_ ] = _*compute_stroke_length_unidimensional_statistics*_ ( _Word_ , _word_type_  , _stroke_criterion_ )
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
% * *Stroke_Length*  : A struct containing all the parameters, organized first in
%                      the norm used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    [ stroke_lengths_modules, stroke_lengths_x, stroke_lengths_y ] = compute_strokes_lengths(iWord,word_type,stroke_criterion);

    [avg_val_l2 , std_val_l2 , min_val_l2 , max_val_l2 , ran_val_l2 , per_val_l2 , skew_val_l2 , kurt_val_l2 ] = compute_unidimensional_statistics(stroke_lengths_modules);    
    [avg_val_x , std_val_x , min_val_x , max_val_x , ran_val_x , per_val_x , skew_val_x , kurt_val_x ] = compute_unidimensional_statistics(stroke_lengths_x);
    [avg_val_y , std_val_y , min_val_y , max_val_y , ran_val_y , per_val_y , skew_val_y , kurt_val_y ] = compute_unidimensional_statistics(stroke_lengths_y);
  
    
    %Mean Values for each norm
    Stroke_Length.L2.mean   = avg_val_l2;
    Stroke_Length.X.mean    = avg_val_x;
    Stroke_Length.Y.mean    = avg_val_y;
    
    %Standard Deviation for each norm
    Stroke_Length.L2.std   = std_val_l2;
    Stroke_Length.X.std    = std_val_x;
    Stroke_Length.Y.std    = std_val_y;
    
    %Minimum value for each norm
    Stroke_Length.L2.min   = min_val_l2;
    Stroke_Length.X.min    = min_val_x;
    Stroke_Length.Y.min    = min_val_y;
    
    %Maximum value for each norm
    Stroke_Length.L2.max   = max_val_l2;
    Stroke_Length.X.max    = max_val_x;
    Stroke_Length.Y.max    = max_val_y;
    
    %Range for each norm
    Stroke_Length.L2.range   = ran_val_l2;
    Stroke_Length.X.range    = ran_val_x;
    Stroke_Length.Y.range    = ran_val_y;
    
    %Percentils for each norm
    Stroke_Length.L2.percentils   = per_val_l2;
    Stroke_Length.X.percentils    = per_val_x;
    Stroke_Length.Y.percentils    = per_val_y;
    
    %Skewness for each norm
    Stroke_Length.L2.skewness   = skew_val_l2;
    Stroke_Length.X.skewness    = skew_val_x;
    Stroke_Length.Y.skewness    = skew_val_y;
    
    %Kurtosis for each norm
    Stroke_Length.L2.kurtosis   = kurt_val_l2;
    Stroke_Length.X.kurtosis    = kurt_val_x;
    Stroke_Length.Y.kurtosis    = kurt_val_y;
    
end