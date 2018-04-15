function [ Curvatures ] = compute_curvature_unidimensional_statistics( Word , word_type , window_size )
%% compute_curvature_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on a word
%  curvature Mean, Std, Min, Max, Range, Percentils (steps of 5%) 
%  this is done using the angles in absolute value 0:180 and the angles 
%  applied to all the basic trigonometric functions in a struct.
%  user must also provide an input specifiying which inclinations should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
% [ _Curvatures_ ] = _*compute_curvature_unidimensional_statistics*_ ( _Word_ , _word_type_ , _window_size_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
% * *window_size* : Size of the window to compute curvature. 
%                   Must be greater than 1. 
%
%%% Outputs
% 
% * *Curvatures*  : A struct containing all the parameters, organized first in
%                   the function used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);
    
    
    [ angle_deg_0_180 , ~ , Trigonometry ] = compute_valid_curvatures(iWord , window_size );
   
    [avg_val_ang_0_180 , std_val_ang_0_180 , min_val_ang_0_180 , max_val_ang_0_180 , ran_val_ang_0_180 , per_val_ang_0_180 , skew_val_ang_0_180 , kurt_val_ang_0_180 ]    = compute_unidimensional_statistics(angle_deg_0_180);    
      
    if( ~isempty(Trigonometry) )
        [avg_val_sin_0_180 , std_val_sin_0_180 , min_val_sin_0_180 , max_val_sin_0_180 , ran_val_sin_0_180 , per_val_sin_0_180 , skew_val_sin_0_180 , kurt_val_sin_0_180 ] = compute_unidimensional_statistics(Trigonometry.sin_angle_0_180);
        [avg_val_cos_0_180 , std_val_cos_0_180 , min_val_cos_0_180 , max_val_cos_0_180 , ran_val_cos_0_180 , per_val_cos_0_180 , skew_val_cos_0_180 , kurt_val_cos_0_180 ] = compute_unidimensional_statistics(Trigonometry.cos_angle_0_180);
        [avg_val_tan_0_180 , std_val_tan_0_180 , min_val_tan_0_180 , max_val_tan_0_180 , ran_val_tan_0_180 , per_val_tan_0_180 , skew_val_tan_0_180 , kurt_val_tan_0_180 ] = compute_unidimensional_statistics(Trigonometry.tan_angle_0_180);
        [avg_val_cot_0_180 , std_val_cot_0_180 , min_val_cot_0_180 , max_val_cot_0_180 , ran_val_cot_0_180 , per_val_cot_0_180 , skew_val_cot_0_180 , kurt_val_cot_0_180 ] = compute_unidimensional_statistics(Trigonometry.cot_angle_0_180);
        [avg_val_sec_0_180 , std_val_sec_0_180 , min_val_sec_0_180 , max_val_sec_0_180 , ran_val_sec_0_180 , per_val_sec_0_180 , skew_val_sec_0_180 , kurt_val_sec_0_180 ] = compute_unidimensional_statistics(Trigonometry.sec_angle_0_180);
        [avg_val_csc_0_180 , std_val_csc_0_180 , min_val_csc_0_180 , max_val_csc_0_180 , ran_val_csc_0_180 , per_val_csc_0_180 , skew_val_csc_0_180 , kurt_val_csc_0_180 ] = compute_unidimensional_statistics(Trigonometry.csc_angle_0_180);

        [avg_val_sinh_0_180 , std_val_sinh_0_180 , min_val_sinh_0_180 , max_val_sinh_0_180 , ran_val_sinh_0_180 , per_val_sinh_0_180 , skew_val_sinh_0_180 , kurt_val_sinh_0_180 ] = compute_unidimensional_statistics(Trigonometry.sin_angle_0_180);
        [avg_val_cosh_0_180 , std_val_cosh_0_180 , min_val_cosh_0_180 , max_val_cosh_0_180 , ran_val_cosh_0_180 , per_val_cosh_0_180 , skew_val_cosh_0_180 , kurt_val_cosh_0_180 ] = compute_unidimensional_statistics(Trigonometry.cos_angle_0_180);
        [avg_val_tanh_0_180 , std_val_tanh_0_180 , min_val_tanh_0_180 , max_val_tanh_0_180 , ran_val_tanh_0_180 , per_val_tanh_0_180 , skew_val_tanh_0_180 , kurt_val_tanh_0_180 ] = compute_unidimensional_statistics(Trigonometry.tan_angle_0_180);
        [avg_val_coth_0_180 , std_val_coth_0_180 , min_val_coth_0_180 , max_val_coth_0_180 , ran_val_coth_0_180 , per_val_coth_0_180 , skew_val_coth_0_180 , kurt_val_coth_0_180 ] = compute_unidimensional_statistics(Trigonometry.cot_angle_0_180);
        [avg_val_sech_0_180 , std_val_sech_0_180 , min_val_sech_0_180 , max_val_sech_0_180 , ran_val_sech_0_180 , per_val_sech_0_180 , skew_val_sech_0_180 , kurt_val_sech_0_180 ] = compute_unidimensional_statistics(Trigonometry.sec_angle_0_180);
        [avg_val_csch_0_180 , std_val_csch_0_180 , min_val_csch_0_180 , max_val_csch_0_180 , ran_val_csch_0_180 , per_val_csch_0_180 , skew_val_csch_0_180 , kurt_val_csch_0_180 ] = compute_unidimensional_statistics(Trigonometry.csc_angle_0_180);
    else
        [avg_val_sin_0_180 , std_val_sin_0_180 , min_val_sin_0_180 , max_val_sin_0_180 , ran_val_sin_0_180 , per_val_sin_0_180 , skew_val_sin_0_180 , kurt_val_sin_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_cos_0_180 , std_val_cos_0_180 , min_val_cos_0_180 , max_val_cos_0_180 , ran_val_cos_0_180 , per_val_cos_0_180 , skew_val_cos_0_180 , kurt_val_cos_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_tan_0_180 , std_val_tan_0_180 , min_val_tan_0_180 , max_val_tan_0_180 , ran_val_tan_0_180 , per_val_tan_0_180 , skew_val_tan_0_180 , kurt_val_tan_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_cot_0_180 , std_val_cot_0_180 , min_val_cot_0_180 , max_val_cot_0_180 , ran_val_cot_0_180 , per_val_cot_0_180 , skew_val_cot_0_180 , kurt_val_cot_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_sec_0_180 , std_val_sec_0_180 , min_val_sec_0_180 , max_val_sec_0_180 , ran_val_sec_0_180 , per_val_sec_0_180 , skew_val_sec_0_180 , kurt_val_sec_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_csc_0_180 , std_val_csc_0_180 , min_val_csc_0_180 , max_val_csc_0_180 , ran_val_csc_0_180 , per_val_csc_0_180 , skew_val_csc_0_180 , kurt_val_csc_0_180 ] = compute_unidimensional_statistics([]);

        [avg_val_sinh_0_180 , std_val_sinh_0_180 , min_val_sinh_0_180 , max_val_sinh_0_180 , ran_val_sinh_0_180 , per_val_sinh_0_180 , skew_val_sinh_0_180 , kurt_val_sinh_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_cosh_0_180 , std_val_cosh_0_180 , min_val_cosh_0_180 , max_val_cosh_0_180 , ran_val_cosh_0_180 , per_val_cosh_0_180 , skew_val_cosh_0_180 , kurt_val_cosh_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_tanh_0_180 , std_val_tanh_0_180 , min_val_tanh_0_180 , max_val_tanh_0_180 , ran_val_tanh_0_180 , per_val_tanh_0_180 , skew_val_tanh_0_180 , kurt_val_tanh_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_coth_0_180 , std_val_coth_0_180 , min_val_coth_0_180 , max_val_coth_0_180 , ran_val_coth_0_180 , per_val_coth_0_180 , skew_val_coth_0_180 , kurt_val_coth_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_sech_0_180 , std_val_sech_0_180 , min_val_sech_0_180 , max_val_sech_0_180 , ran_val_sech_0_180 , per_val_sech_0_180 , skew_val_sech_0_180 , kurt_val_sech_0_180 ] = compute_unidimensional_statistics([]);
        [avg_val_csch_0_180 , std_val_csch_0_180 , min_val_csch_0_180 , max_val_csch_0_180 , ran_val_csch_0_180 , per_val_csch_0_180 , skew_val_csch_0_180 , kurt_val_csch_0_180 ] = compute_unidimensional_statistics([]);       
    end
    
    %Mean Values for each norm
    Curvatures.angle_0_180.mean   = avg_val_ang_0_180;
    Curvatures.sin_0_180.mean     = avg_val_sin_0_180;
    Curvatures.cos_0_180.mean     = avg_val_cos_0_180;
    Curvatures.tan_0_180.mean     = avg_val_tan_0_180;
    Curvatures.sec_0_180.mean     = avg_val_sec_0_180;
    Curvatures.cot_0_180.mean     = avg_val_cot_0_180;
    Curvatures.csc_0_180.mean     = avg_val_csc_0_180;
    Curvatures.sinh_0_180.mean    = avg_val_sinh_0_180;
    Curvatures.cosh_0_180.mean    = avg_val_cosh_0_180;
    Curvatures.tanh_0_180.mean    = avg_val_tanh_0_180;
    Curvatures.sech_0_180.mean    = avg_val_sech_0_180;
    Curvatures.coth_0_180.mean    = avg_val_coth_0_180;
    Curvatures.csch_0_180.mean    = avg_val_csch_0_180;
    
    
    %Standard Deviation for each norm
    Curvatures.angle_0_180.std  = std_val_ang_0_180;
    Curvatures.sin_0_180.std    = std_val_sin_0_180;
    Curvatures.cos_0_180.std    = std_val_cos_0_180;
    Curvatures.tan_0_180.std    = std_val_tan_0_180;
    Curvatures.sec_0_180.std    = std_val_sec_0_180;
    Curvatures.cot_0_180.std    = std_val_cot_0_180;
    Curvatures.csc_0_180.std    = std_val_csc_0_180;
    Curvatures.sinh_0_180.std   = std_val_sinh_0_180;
    Curvatures.cosh_0_180.std   = std_val_cosh_0_180;
    Curvatures.tanh_0_180.std   = std_val_tanh_0_180;
    Curvatures.sech_0_180.std   = std_val_sech_0_180;
    Curvatures.coth_0_180.std   = std_val_coth_0_180;
    Curvatures.csch_0_180.std   = std_val_csch_0_180;
    
    %Minimum value for each norm
    Curvatures.angle_0_180.min  = min_val_ang_0_180;
    Curvatures.sin_0_180.min    = min_val_sin_0_180;
    Curvatures.cos_0_180.min    = min_val_cos_0_180;
    Curvatures.tan_0_180.min    = min_val_tan_0_180;
    Curvatures.sec_0_180.min    = min_val_sec_0_180;
    Curvatures.cot_0_180.min    = min_val_cot_0_180;
    Curvatures.csc_0_180.min    = min_val_csc_0_180;
    Curvatures.sinh_0_180.min   = min_val_sinh_0_180;
    Curvatures.cosh_0_180.min   = min_val_cosh_0_180;
    Curvatures.tanh_0_180.min   = min_val_tanh_0_180;
    Curvatures.sech_0_180.min   = min_val_sech_0_180;
    Curvatures.coth_0_180.min   = min_val_coth_0_180;
    Curvatures.csch_0_180.min   = min_val_csch_0_180;
    
    
    %Maximum value for each norm
    Curvatures.angle_0_180.max  = max_val_ang_0_180;
    Curvatures.sin_0_180.max    = max_val_sin_0_180;
    Curvatures.cos_0_180.max    = max_val_cos_0_180;
    Curvatures.tan_0_180.max    = max_val_tan_0_180;
    Curvatures.sec_0_180.max    = max_val_sec_0_180;
    Curvatures.cot_0_180.max    = max_val_cot_0_180;
    Curvatures.csc_0_180.max    = max_val_csc_0_180;
    Curvatures.sinh_0_180.max   = max_val_sinh_0_180;
    Curvatures.cosh_0_180.max   = max_val_cosh_0_180;
    Curvatures.tanh_0_180.max   = max_val_tanh_0_180;
    Curvatures.sech_0_180.max   = max_val_sech_0_180;
    Curvatures.coth_0_180.max   = max_val_coth_0_180;
    Curvatures.csch_0_180.max   = max_val_csch_0_180;
    
    %Range for each norm
    Curvatures.angle_0_180.range  = ran_val_ang_0_180;
    Curvatures.sin_0_180.range    = ran_val_sin_0_180;
    Curvatures.cos_0_180.range    = ran_val_cos_0_180;
    Curvatures.tan_0_180.range    = ran_val_tan_0_180;
    Curvatures.sec_0_180.range    = ran_val_sec_0_180;
    Curvatures.cot_0_180.range    = ran_val_cot_0_180;
    Curvatures.csc_0_180.range    = ran_val_csc_0_180;
    Curvatures.sinh_0_180.range   = ran_val_sinh_0_180;
    Curvatures.cosh_0_180.range   = ran_val_cosh_0_180;
    Curvatures.tanh_0_180.range   = ran_val_tanh_0_180;
    Curvatures.sech_0_180.range   = ran_val_sech_0_180;
    Curvatures.coth_0_180.range   = ran_val_coth_0_180;
    Curvatures.csch_0_180.range   = ran_val_csch_0_180;
    
    %Percentils for each norm
    Curvatures.angle_0_180.percentils = per_val_ang_0_180;
    Curvatures.sin_0_180.percentils   = per_val_sin_0_180;
    Curvatures.cos_0_180.percentils   = per_val_cos_0_180;
    Curvatures.tan_0_180.percentils   = per_val_tan_0_180;
    Curvatures.sec_0_180.percentils   = per_val_sec_0_180;
    Curvatures.cot_0_180.percentils   = per_val_cot_0_180;
    Curvatures.csc_0_180.percentils   = per_val_csc_0_180;
    Curvatures.sinh_0_180.percentils  = per_val_sinh_0_180;
    Curvatures.cosh_0_180.percentils  = per_val_cosh_0_180;
    Curvatures.tanh_0_180.percentils  = per_val_tanh_0_180;
    Curvatures.sech_0_180.percentils  = per_val_sech_0_180;
    Curvatures.coth_0_180.percentils  = per_val_coth_0_180;
    Curvatures.csch_0_180.percentils  = per_val_csch_0_180;
    
    %Skewness for each norm
    Curvatures.angle_0_180.skewness = skew_val_ang_0_180;
    Curvatures.sin_0_180.skewness   = skew_val_sin_0_180;
    Curvatures.cos_0_180.skewness   = skew_val_cos_0_180;
    Curvatures.tan_0_180.skewness   = skew_val_tan_0_180;
    Curvatures.sec_0_180.skewness   = skew_val_sec_0_180;
    Curvatures.cot_0_180.skewness   = skew_val_cot_0_180;
    Curvatures.csc_0_180.skewness   = skew_val_csc_0_180;
    Curvatures.sinh_0_180.skewness  = skew_val_sinh_0_180;
    Curvatures.cosh_0_180.skewness  = skew_val_cosh_0_180;
    Curvatures.tanh_0_180.skewness  = skew_val_tanh_0_180;
    Curvatures.sech_0_180.skewness  = skew_val_sech_0_180;
    Curvatures.coth_0_180.skewness  = skew_val_coth_0_180;
    Curvatures.csch_0_180.skewness  = skew_val_csch_0_180;
    
    %Kurtosis for each norm
    Curvatures.angle_0_180.kurtosis = kurt_val_ang_0_180;
    Curvatures.sin_0_180.kurtosis   = kurt_val_sin_0_180;
    Curvatures.cos_0_180.kurtosis   = kurt_val_cos_0_180;
    Curvatures.tan_0_180.kurtosis   = kurt_val_tan_0_180;
    Curvatures.sec_0_180.kurtosis   = kurt_val_sec_0_180;
    Curvatures.cot_0_180.kurtosis   = kurt_val_cot_0_180;
    Curvatures.csc_0_180.kurtosis   = kurt_val_csc_0_180;
    Curvatures.sinh_0_180.kurtosis  = kurt_val_sinh_0_180;
    Curvatures.cosh_0_180.kurtosis  = kurt_val_cosh_0_180;
    Curvatures.tanh_0_180.kurtosis  = kurt_val_tanh_0_180;
    Curvatures.sech_0_180.kurtosis  = kurt_val_sech_0_180;
    Curvatures.coth_0_180.kurtosis  = kurt_val_coth_0_180;
    Curvatures.csch_0_180.kurtosis  = kurt_val_csch_0_180;
    
end