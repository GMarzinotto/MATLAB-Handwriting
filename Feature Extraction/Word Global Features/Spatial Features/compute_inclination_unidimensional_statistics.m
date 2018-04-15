function [ Inclinations ] = compute_inclination_unidimensional_statistics(Word,word_type)
%% compute_inclination_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on a word
%  inclination Mean, Std, Min, Max, Range, Percentils (steps of 5%) 
%  this is done using the angles in range -180:180, ther equivalent
%  absolute value 0:180 and the angles applied to all the basic
%  trigonometric functions in a struct.
%  user must also provide an input specifiying which inclinations should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
% [ _Inclinations_ ] = _*compute_inclination_unidimensional_statistics*_ ( _Word_ , _word_type_ )
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
% * *Inclinations*  : A struct containing all the parameters, organized first in
%                     the function used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    [ angle_deg_0_360 , angle_deg_0_180 , angle_deg_0_90 , Trigonometry ] = compute_valid_inclinations(iWord);

    
    [ avg_val_ang_0_360 , std_val_ang_0_360 , min_val_ang_0_360 , max_val_ang_0_360 , ran_val_ang_0_360 , per_val_ang_0_360 , skew_val_ang_0_360 , kurt_val_ang_0_360 ]    = compute_unidimensional_statistics(angle_deg_0_360);
    [ avg_val_ang_0_180 , std_val_ang_0_180 , min_val_ang_0_180 , max_val_ang_0_180 , ran_val_ang_0_180 , per_val_ang_0_180 , skew_val_ang_0_180 , kurt_val_ang_0_180 ]    = compute_unidimensional_statistics(angle_deg_0_180);
    [ avg_val_ang_0_90  , std_val_ang_0_90  , min_val_ang_0_90  , max_val_ang_0_90  , ran_val_ang_0_90  , per_val_ang_0_90  , skew_val_ang_0_90  , kurt_val_ang_0_90  ]    = compute_unidimensional_statistics(angle_deg_0_90);
    
    if( ~isempty(Trigonometry))
        
        [avg_val_sin_0_360 , std_val_sin_0_360 , min_val_sin_0_360 , max_val_sin_0_360 , ran_val_sin_0_360 , per_val_sin_0_360 , skew_val_sin_0_360 , kurt_val_sin_0_360 ] = compute_unidimensional_statistics(Trigonometry.sin_angle_0_360);
        [avg_val_cos_0_360 , std_val_cos_0_360 , min_val_cos_0_360 , max_val_cos_0_360 , ran_val_cos_0_360 , per_val_cos_0_360 , skew_val_cos_0_360 , kurt_val_cos_0_360 ] = compute_unidimensional_statistics(Trigonometry.cos_angle_0_360);
        [avg_val_tan_0_360 , std_val_tan_0_360 , min_val_tan_0_360 , max_val_tan_0_360 , ran_val_tan_0_360 , per_val_tan_0_360 , skew_val_tan_0_360 , kurt_val_tan_0_360 ] = compute_unidimensional_statistics(Trigonometry.tan_angle_0_360);
        [avg_val_cot_0_360 , std_val_cot_0_360 , min_val_cot_0_360 , max_val_cot_0_360 , ran_val_cot_0_360 , per_val_cot_0_360 , skew_val_cot_0_360 , kurt_val_cot_0_360 ] = compute_unidimensional_statistics(Trigonometry.cot_angle_0_360);
        [avg_val_sec_0_360 , std_val_sec_0_360 , min_val_sec_0_360 , max_val_sec_0_360 , ran_val_sec_0_360 , per_val_sec_0_360 , skew_val_sec_0_360 , kurt_val_sec_0_360 ] = compute_unidimensional_statistics(Trigonometry.sec_angle_0_360);
        [avg_val_csc_0_360 , std_val_csc_0_360 , min_val_csc_0_360 , max_val_csc_0_360 , ran_val_csc_0_360 , per_val_csc_0_360 , skew_val_csc_0_360 , kurt_val_csc_0_360 ] = compute_unidimensional_statistics(Trigonometry.csc_angle_0_360);

        [avg_val_sinh_0_360 , std_val_sinh_0_360 , min_val_sinh_0_360 , max_val_sinh_0_360 , ran_val_sinh_0_360 , per_val_sinh_0_360 , skew_val_sinh_0_360 , kurt_val_sinh_0_360 ] = compute_unidimensional_statistics(Trigonometry.sin_angle_0_360);
        [avg_val_cosh_0_360 , std_val_cosh_0_360 , min_val_cosh_0_360 , max_val_cosh_0_360 , ran_val_cosh_0_360 , per_val_cosh_0_360 , skew_val_cosh_0_360 , kurt_val_cosh_0_360 ] = compute_unidimensional_statistics(Trigonometry.cos_angle_0_360);
        [avg_val_tanh_0_360 , std_val_tanh_0_360 , min_val_tanh_0_360 , max_val_tanh_0_360 , ran_val_tanh_0_360 , per_val_tanh_0_360 , skew_val_tanh_0_360 , kurt_val_tanh_0_360 ] = compute_unidimensional_statistics(Trigonometry.tan_angle_0_360);
        [avg_val_coth_0_360 , std_val_coth_0_360 , min_val_coth_0_360 , max_val_coth_0_360 , ran_val_coth_0_360 , per_val_coth_0_360 , skew_val_coth_0_360 , kurt_val_coth_0_360 ] = compute_unidimensional_statistics(Trigonometry.cot_angle_0_360);
        [avg_val_sech_0_360 , std_val_sech_0_360 , min_val_sech_0_360 , max_val_sech_0_360 , ran_val_sech_0_360 , per_val_sech_0_360 , skew_val_sech_0_360 , kurt_val_sech_0_360 ] = compute_unidimensional_statistics(Trigonometry.sec_angle_0_360);
        [avg_val_csch_0_360 , std_val_csch_0_360 , min_val_csch_0_360 , max_val_csch_0_360 , ran_val_csch_0_360 , per_val_csch_0_360 , skew_val_csch_0_360 , kurt_val_csch_0_360 ] = compute_unidimensional_statistics(Trigonometry.csc_angle_0_360);


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


        [avg_val_sin_0_90 , std_val_sin_0_90 , min_val_sin_0_90 , max_val_sin_0_90 , ran_val_sin_0_90 , per_val_sin_0_90 , skew_val_sin_0_90 , kurt_val_sin_0_90 ] = compute_unidimensional_statistics(Trigonometry.sin_angle_0_90);
        [avg_val_cos_0_90 , std_val_cos_0_90 , min_val_cos_0_90 , max_val_cos_0_90 , ran_val_cos_0_90 , per_val_cos_0_90 , skew_val_cos_0_90 , kurt_val_cos_0_90 ] = compute_unidimensional_statistics(Trigonometry.cos_angle_0_90);
        [avg_val_tan_0_90 , std_val_tan_0_90 , min_val_tan_0_90 , max_val_tan_0_90 , ran_val_tan_0_90 , per_val_tan_0_90 , skew_val_tan_0_90 , kurt_val_tan_0_90 ] = compute_unidimensional_statistics(Trigonometry.tan_angle_0_90);
        [avg_val_cot_0_90 , std_val_cot_0_90 , min_val_cot_0_90 , max_val_cot_0_90 , ran_val_cot_0_90 , per_val_cot_0_90 , skew_val_cot_0_90 , kurt_val_cot_0_90 ] = compute_unidimensional_statistics(Trigonometry.cot_angle_0_90);
        [avg_val_sec_0_90 , std_val_sec_0_90 , min_val_sec_0_90 , max_val_sec_0_90 , ran_val_sec_0_90 , per_val_sec_0_90 , skew_val_sec_0_90 , kurt_val_sec_0_90 ] = compute_unidimensional_statistics(Trigonometry.sec_angle_0_90);
        [avg_val_csc_0_90 , std_val_csc_0_90 , min_val_csc_0_90 , max_val_csc_0_90 , ran_val_csc_0_90 , per_val_csc_0_90 , skew_val_csc_0_90 , kurt_val_csc_0_90 ] = compute_unidimensional_statistics(Trigonometry.csc_angle_0_90);

        [avg_val_sinh_0_90 , std_val_sinh_0_90 , min_val_sinh_0_90 , max_val_sinh_0_90 , ran_val_sinh_0_90 , per_val_sinh_0_90 , skew_val_sinh_0_90 , kurt_val_sinh_0_90 ] = compute_unidimensional_statistics(Trigonometry.sin_angle_0_90);
        [avg_val_cosh_0_90 , std_val_cosh_0_90 , min_val_cosh_0_90 , max_val_cosh_0_90 , ran_val_cosh_0_90 , per_val_cosh_0_90 , skew_val_cosh_0_90 , kurt_val_cosh_0_90 ] = compute_unidimensional_statistics(Trigonometry.cos_angle_0_90);
        [avg_val_tanh_0_90 , std_val_tanh_0_90 , min_val_tanh_0_90 , max_val_tanh_0_90 , ran_val_tanh_0_90 , per_val_tanh_0_90 , skew_val_tanh_0_90 , kurt_val_tanh_0_90 ] = compute_unidimensional_statistics(Trigonometry.tan_angle_0_90);
        [avg_val_coth_0_90 , std_val_coth_0_90 , min_val_coth_0_90 , max_val_coth_0_90 , ran_val_coth_0_90 , per_val_coth_0_90 , skew_val_coth_0_90 , kurt_val_coth_0_90 ] = compute_unidimensional_statistics(Trigonometry.cot_angle_0_90);
        [avg_val_sech_0_90 , std_val_sech_0_90 , min_val_sech_0_90 , max_val_sech_0_90 , ran_val_sech_0_90 , per_val_sech_0_90 , skew_val_sech_0_90 , kurt_val_sech_0_90 ] = compute_unidimensional_statistics(Trigonometry.sec_angle_0_90);
        [avg_val_csch_0_90 , std_val_csch_0_90 , min_val_csch_0_90 , max_val_csch_0_90 , ran_val_csch_0_90 , per_val_csch_0_90 , skew_val_csch_0_90 , kurt_val_csch_0_90 ] = compute_unidimensional_statistics(Trigonometry.csc_angle_0_90);

    else
        
        [avg_val_sin_0_360 , std_val_sin_0_360 , min_val_sin_0_360 , max_val_sin_0_360 , ran_val_sin_0_360 , per_val_sin_0_360 , skew_val_sin_0_360 , kurt_val_sin_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_cos_0_360 , std_val_cos_0_360 , min_val_cos_0_360 , max_val_cos_0_360 , ran_val_cos_0_360 , per_val_cos_0_360 , skew_val_cos_0_360 , kurt_val_cos_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_tan_0_360 , std_val_tan_0_360 , min_val_tan_0_360 , max_val_tan_0_360 , ran_val_tan_0_360 , per_val_tan_0_360 , skew_val_tan_0_360 , kurt_val_tan_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_cot_0_360 , std_val_cot_0_360 , min_val_cot_0_360 , max_val_cot_0_360 , ran_val_cot_0_360 , per_val_cot_0_360 , skew_val_cot_0_360 , kurt_val_cot_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_sec_0_360 , std_val_sec_0_360 , min_val_sec_0_360 , max_val_sec_0_360 , ran_val_sec_0_360 , per_val_sec_0_360 , skew_val_sec_0_360 , kurt_val_sec_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_csc_0_360 , std_val_csc_0_360 , min_val_csc_0_360 , max_val_csc_0_360 , ran_val_csc_0_360 , per_val_csc_0_360 , skew_val_csc_0_360 , kurt_val_csc_0_360 ] = compute_unidimensional_statistics([]);

        [avg_val_sinh_0_360 , std_val_sinh_0_360 , min_val_sinh_0_360 , max_val_sinh_0_360 , ran_val_sinh_0_360 , per_val_sinh_0_360 , skew_val_sinh_0_360 , kurt_val_sinh_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_cosh_0_360 , std_val_cosh_0_360 , min_val_cosh_0_360 , max_val_cosh_0_360 , ran_val_cosh_0_360 , per_val_cosh_0_360 , skew_val_cosh_0_360 , kurt_val_cosh_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_tanh_0_360 , std_val_tanh_0_360 , min_val_tanh_0_360 , max_val_tanh_0_360 , ran_val_tanh_0_360 , per_val_tanh_0_360 , skew_val_tanh_0_360 , kurt_val_tanh_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_coth_0_360 , std_val_coth_0_360 , min_val_coth_0_360 , max_val_coth_0_360 , ran_val_coth_0_360 , per_val_coth_0_360 , skew_val_coth_0_360 , kurt_val_coth_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_sech_0_360 , std_val_sech_0_360 , min_val_sech_0_360 , max_val_sech_0_360 , ran_val_sech_0_360 , per_val_sech_0_360 , skew_val_sech_0_360 , kurt_val_sech_0_360 ] = compute_unidimensional_statistics([]);
        [avg_val_csch_0_360 , std_val_csch_0_360 , min_val_csch_0_360 , max_val_csch_0_360 , ran_val_csch_0_360 , per_val_csch_0_360 , skew_val_csch_0_360 , kurt_val_csch_0_360 ] = compute_unidimensional_statistics([]);


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


        [avg_val_sin_0_90 , std_val_sin_0_90 , min_val_sin_0_90 , max_val_sin_0_90 , ran_val_sin_0_90 , per_val_sin_0_90 , skew_val_sin_0_90 , kurt_val_sin_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_cos_0_90 , std_val_cos_0_90 , min_val_cos_0_90 , max_val_cos_0_90 , ran_val_cos_0_90 , per_val_cos_0_90 , skew_val_cos_0_90 , kurt_val_cos_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_tan_0_90 , std_val_tan_0_90 , min_val_tan_0_90 , max_val_tan_0_90 , ran_val_tan_0_90 , per_val_tan_0_90 , skew_val_tan_0_90 , kurt_val_tan_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_cot_0_90 , std_val_cot_0_90 , min_val_cot_0_90 , max_val_cot_0_90 , ran_val_cot_0_90 , per_val_cot_0_90 , skew_val_cot_0_90 , kurt_val_cot_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_sec_0_90 , std_val_sec_0_90 , min_val_sec_0_90 , max_val_sec_0_90 , ran_val_sec_0_90 , per_val_sec_0_90 , skew_val_sec_0_90 , kurt_val_sec_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_csc_0_90 , std_val_csc_0_90 , min_val_csc_0_90 , max_val_csc_0_90 , ran_val_csc_0_90 , per_val_csc_0_90 , skew_val_csc_0_90 , kurt_val_csc_0_90 ] = compute_unidimensional_statistics([]);

        [avg_val_sinh_0_90 , std_val_sinh_0_90 , min_val_sinh_0_90 , max_val_sinh_0_90 , ran_val_sinh_0_90 , per_val_sinh_0_90 , skew_val_sinh_0_90 , kurt_val_sinh_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_cosh_0_90 , std_val_cosh_0_90 , min_val_cosh_0_90 , max_val_cosh_0_90 , ran_val_cosh_0_90 , per_val_cosh_0_90 , skew_val_cosh_0_90 , kurt_val_cosh_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_tanh_0_90 , std_val_tanh_0_90 , min_val_tanh_0_90 , max_val_tanh_0_90 , ran_val_tanh_0_90 , per_val_tanh_0_90 , skew_val_tanh_0_90 , kurt_val_tanh_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_coth_0_90 , std_val_coth_0_90 , min_val_coth_0_90 , max_val_coth_0_90 , ran_val_coth_0_90 , per_val_coth_0_90 , skew_val_coth_0_90 , kurt_val_coth_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_sech_0_90 , std_val_sech_0_90 , min_val_sech_0_90 , max_val_sech_0_90 , ran_val_sech_0_90 , per_val_sech_0_90 , skew_val_sech_0_90 , kurt_val_sech_0_90 ] = compute_unidimensional_statistics([]);
        [avg_val_csch_0_90 , std_val_csch_0_90 , min_val_csch_0_90 , max_val_csch_0_90 , ran_val_csch_0_90 , per_val_csch_0_90 , skew_val_csch_0_90 , kurt_val_csch_0_90 ] = compute_unidimensional_statistics([]);
        
    end
    
    %Mean Values for each norm
    Inclinations.angle_0_360.mean       = avg_val_ang_0_360;
    Inclinations.sin_0_360.mean       = avg_val_sin_0_360;
    Inclinations.cos_0_360.mean       = avg_val_cos_0_360;
    Inclinations.tan_0_360.mean       = avg_val_tan_0_360;
    Inclinations.sec_0_360.mean       = avg_val_sec_0_360;
    Inclinations.cot_0_360.mean       = avg_val_cot_0_360;
    Inclinations.csc_0_360.mean       = avg_val_csc_0_360;
    Inclinations.sinh_0_360.mean      = avg_val_sinh_0_360;
    Inclinations.cosh_0_360.mean      = avg_val_cosh_0_360;
    Inclinations.tanh_0_360.mean      = avg_val_tanh_0_360;
    Inclinations.sech_0_360.mean      = avg_val_sech_0_360;
    Inclinations.coth_0_360.mean      = avg_val_coth_0_360;
    Inclinations.csch_0_360.mean      = avg_val_csch_0_360;
    
    Inclinations.angle_0_180.mean   = avg_val_ang_0_180;
    Inclinations.sin_0_180.mean   = avg_val_sin_0_180;
    Inclinations.cos_0_180.mean   = avg_val_cos_0_180;
    Inclinations.tan_0_180.mean   = avg_val_tan_0_180;
    Inclinations.sec_0_180.mean   = avg_val_sec_0_180;
    Inclinations.cot_0_180.mean   = avg_val_cot_0_180;
    Inclinations.csc_0_180.mean   = avg_val_csc_0_180;
    Inclinations.sinh_0_180.mean  = avg_val_sinh_0_180;
    Inclinations.cosh_0_180.mean  = avg_val_cosh_0_180;
    Inclinations.tanh_0_180.mean  = avg_val_tanh_0_180;
    Inclinations.sech_0_180.mean  = avg_val_sech_0_180;
    Inclinations.coth_0_180.mean  = avg_val_coth_0_180;
    Inclinations.csch_0_180.mean  = avg_val_csch_0_180;
    
    Inclinations.angle_0_90.mean   = avg_val_ang_0_90;
    Inclinations.sin_0_90.mean   = avg_val_sin_0_90;
    Inclinations.cos_0_90.mean   = avg_val_cos_0_90;
    Inclinations.tan_0_90.mean   = avg_val_tan_0_90;
    Inclinations.sec_0_90.mean   = avg_val_sec_0_90;
    Inclinations.cot_0_90.mean   = avg_val_cot_0_90;
    Inclinations.csc_0_90.mean   = avg_val_csc_0_90;
    Inclinations.sinh_0_90.mean  = avg_val_sinh_0_90;
    Inclinations.cosh_0_90.mean  = avg_val_cosh_0_90;
    Inclinations.tanh_0_90.mean  = avg_val_tanh_0_90;
    Inclinations.sech_0_90.mean  = avg_val_sech_0_90;
    Inclinations.coth_0_90.mean  = avg_val_coth_0_90;
    Inclinations.csch_0_90.mean  = avg_val_csch_0_90;
    
    
    %Standard Deviation for each norm
    Inclinations.angle_0_360.std    = std_val_ang_0_360;
    Inclinations.sin_0_360.std    = std_val_sin_0_360;
    Inclinations.cos_0_360.std    = std_val_cos_0_360;
    Inclinations.tan_0_360.std    = std_val_tan_0_360;
    Inclinations.sec_0_360.std    = std_val_sec_0_360;
    Inclinations.cot_0_360.std    = std_val_cot_0_360;
    Inclinations.csc_0_360.std    = std_val_csc_0_360;
    Inclinations.sinh_0_360.std   = std_val_sinh_0_360;
    Inclinations.cosh_0_360.std   = std_val_cosh_0_360;
    Inclinations.tanh_0_360.std   = std_val_tanh_0_360;
    Inclinations.sech_0_360.std   = std_val_sech_0_360;
    Inclinations.coth_0_360.std   = std_val_coth_0_360;
    Inclinations.csch_0_360.std   = std_val_csch_0_360;
    
    Inclinations.angle_0_180.std    = std_val_ang_0_180;
    Inclinations.sin_0_180.std    = std_val_sin_0_180;
    Inclinations.cos_0_180.std    = std_val_cos_0_180;
    Inclinations.tan_0_180.std    = std_val_tan_0_180;
    Inclinations.sec_0_180.std    = std_val_sec_0_180;
    Inclinations.cot_0_180.std    = std_val_cot_0_180;
    Inclinations.csc_0_180.std    = std_val_csc_0_180;
    Inclinations.sinh_0_180.std   = std_val_sinh_0_180;
    Inclinations.cosh_0_180.std   = std_val_cosh_0_180;
    Inclinations.tanh_0_180.std   = std_val_tanh_0_180;
    Inclinations.sech_0_180.std   = std_val_sech_0_180;
    Inclinations.coth_0_180.std   = std_val_coth_0_180;
    Inclinations.csch_0_180.std   = std_val_csch_0_180;
    
    Inclinations.angle_0_90.std    = std_val_ang_0_90;
    Inclinations.sin_0_90.std    = std_val_sin_0_90;
    Inclinations.cos_0_90.std    = std_val_cos_0_90;
    Inclinations.tan_0_90.std    = std_val_tan_0_90;
    Inclinations.sec_0_90.std    = std_val_sec_0_90;
    Inclinations.cot_0_90.std    = std_val_cot_0_90;
    Inclinations.csc_0_90.std    = std_val_csc_0_90;
    Inclinations.sinh_0_90.std   = std_val_sinh_0_90;
    Inclinations.cosh_0_90.std   = std_val_cosh_0_90;
    Inclinations.tanh_0_90.std   = std_val_tanh_0_90;
    Inclinations.sech_0_90.std   = std_val_sech_0_90;
    Inclinations.coth_0_90.std   = std_val_coth_0_90;
    Inclinations.csch_0_90.std   = std_val_csch_0_90;
    
	%Minimum value for each norm
    Inclinations.angle_0_360.min    = min_val_ang_0_360;
    Inclinations.sin_0_360.min    = min_val_sin_0_360;
    Inclinations.cos_0_360.min    = min_val_cos_0_360;
    Inclinations.tan_0_360.min    = min_val_tan_0_360;
    Inclinations.sec_0_360.min    = min_val_sec_0_360;
    Inclinations.cot_0_360.min    = min_val_cot_0_360;
    Inclinations.csc_0_360.min    = min_val_csc_0_360;
    Inclinations.sinh_0_360.min   = min_val_sinh_0_360;
    Inclinations.cosh_0_360.min   = min_val_cosh_0_360;
    Inclinations.tanh_0_360.min   = min_val_tanh_0_360;
    Inclinations.sech_0_360.min   = min_val_sech_0_360;
    Inclinations.coth_0_360.min   = min_val_coth_0_360;
    Inclinations.csch_0_360.min   = min_val_csch_0_360;
	
	Inclinations.angle_0_180.min    = min_val_ang_0_180;
    Inclinations.sin_0_180.min    = min_val_sin_0_180;
    Inclinations.cos_0_180.min    = min_val_cos_0_180;
    Inclinations.tan_0_180.min    = min_val_tan_0_180;
    Inclinations.sec_0_180.min    = min_val_sec_0_180;
    Inclinations.cot_0_180.min    = min_val_cot_0_180;
    Inclinations.csc_0_180.min    = min_val_csc_0_180;
    Inclinations.sinh_0_180.min   = min_val_sinh_0_180;
    Inclinations.cosh_0_180.min   = min_val_cosh_0_180;
    Inclinations.tanh_0_180.min   = min_val_tanh_0_180;
    Inclinations.sech_0_180.min   = min_val_sech_0_180;
    Inclinations.coth_0_180.min   = min_val_coth_0_180;
    Inclinations.csch_0_180.min   = min_val_csch_0_180;
	
	Inclinations.angle_0_90.min     = min_val_ang_0_90;
    Inclinations.sin_0_90.min     = min_val_sin_0_90;
    Inclinations.cos_0_90.min     = min_val_cos_0_90;
    Inclinations.tan_0_90.min     = min_val_tan_0_90;
    Inclinations.sec_0_90.min     = min_val_sec_0_90;
    Inclinations.cot_0_90.min     = min_val_cot_0_90;
    Inclinations.csc_0_90.min     = min_val_csc_0_90;
    Inclinations.sinh_0_90.min    = min_val_sinh_0_90;
    Inclinations.cosh_0_90.min    = min_val_cosh_0_90;
    Inclinations.tanh_0_90.min    = min_val_tanh_0_90;
    Inclinations.sech_0_90.min    = min_val_sech_0_90;
    Inclinations.coth_0_90.min    = min_val_coth_0_90;
    Inclinations.csch_0_90.min    = min_val_csch_0_90;
    
    
    %Maximum value for each norm
    Inclinations.angle_0_360.max    = max_val_ang_0_360;
    Inclinations.sin_0_360.max    = max_val_sin_0_360;
    Inclinations.cos_0_360.max    = max_val_cos_0_360;
    Inclinations.tan_0_360.max    = max_val_tan_0_360;
    Inclinations.sec_0_360.max    = max_val_sec_0_360;
    Inclinations.cot_0_360.max    = max_val_cot_0_360;
    Inclinations.csc_0_360.max    = max_val_csc_0_360;
    Inclinations.sinh_0_360.max   = max_val_sinh_0_360;
    Inclinations.cosh_0_360.max   = max_val_cosh_0_360;
    Inclinations.tanh_0_360.max   = max_val_tanh_0_360;
    Inclinations.sech_0_360.max   = max_val_sech_0_360;
    Inclinations.coth_0_360.max   = max_val_coth_0_360;
    Inclinations.csch_0_360.max   = max_val_csch_0_360;
	
	Inclinations.angle_0_180.max    = max_val_ang_0_180;
    Inclinations.sin_0_180.max    = max_val_sin_0_180;
    Inclinations.cos_0_180.max    = max_val_cos_0_180;
    Inclinations.tan_0_180.max    = max_val_tan_0_180;
    Inclinations.sec_0_180.max    = max_val_sec_0_180;
    Inclinations.cot_0_180.max    = max_val_cot_0_180;
    Inclinations.csc_0_180.max    = max_val_csc_0_180;
    Inclinations.sinh_0_180.max   = max_val_sinh_0_180;
    Inclinations.cosh_0_180.max   = max_val_cosh_0_180;
    Inclinations.tanh_0_180.max   = max_val_tanh_0_180;
    Inclinations.sech_0_180.max   = max_val_sech_0_180;
    Inclinations.coth_0_180.max   = max_val_coth_0_180;
    Inclinations.csch_0_180.max   = max_val_csch_0_180;
		
	Inclinations.angle_0_90.max     = max_val_ang_0_90;
    Inclinations.sin_0_90.max     = max_val_sin_0_90;
    Inclinations.cos_0_90.max     = max_val_cos_0_90;
    Inclinations.tan_0_90.max     = max_val_tan_0_90;
    Inclinations.sec_0_90.max     = max_val_sec_0_90;
    Inclinations.cot_0_90.max     = max_val_cot_0_90;
    Inclinations.csc_0_90.max     = max_val_csc_0_90;
    Inclinations.sinh_0_90.max    = max_val_sinh_0_90;
    Inclinations.cosh_0_90.max    = max_val_cosh_0_90;
    Inclinations.tanh_0_90.max    = max_val_tanh_0_90;
    Inclinations.sech_0_90.max    = max_val_sech_0_90;
    Inclinations.coth_0_90.max    = max_val_coth_0_90;
    Inclinations.csch_0_90.max    = max_val_csch_0_90;
    
	
	
    %Range for each norm
    Inclinations.angle_0_360.range  = ran_val_ang_0_360;
    Inclinations.sin_0_360.range  = ran_val_sin_0_360;
    Inclinations.cos_0_360.range  = ran_val_cos_0_360;
    Inclinations.tan_0_360.range  = ran_val_tan_0_360;
    Inclinations.sec_0_360.range  = ran_val_sec_0_360;
    Inclinations.cot_0_360.range  = ran_val_cot_0_360;
    Inclinations.csc_0_360.range  = ran_val_csc_0_360;
    Inclinations.sinh_0_360.range = ran_val_sinh_0_360;
    Inclinations.cosh_0_360.range = ran_val_cosh_0_360;
    Inclinations.tanh_0_360.range = ran_val_tanh_0_360;
    Inclinations.sech_0_360.range = ran_val_sech_0_360;
    Inclinations.coth_0_360.range = ran_val_coth_0_360;
    Inclinations.csch_0_360.range = ran_val_csch_0_360;
	
	Inclinations.angle_0_180.range  = ran_val_ang_0_180;
    Inclinations.sin_0_180.range  = ran_val_sin_0_180;
    Inclinations.cos_0_180.range  = ran_val_cos_0_180;
    Inclinations.tan_0_180.range  = ran_val_tan_0_180;
    Inclinations.sec_0_180.range  = ran_val_sec_0_180;
    Inclinations.cot_0_180.range  = ran_val_cot_0_180;
    Inclinations.csc_0_180.range  = ran_val_csc_0_180;
    Inclinations.sinh_0_180.range = ran_val_sinh_0_180;
    Inclinations.cosh_0_180.range = ran_val_cosh_0_180;
    Inclinations.tanh_0_180.range = ran_val_tanh_0_180;
    Inclinations.sech_0_180.range = ran_val_sech_0_180;
    Inclinations.coth_0_180.range = ran_val_coth_0_180;
    Inclinations.csch_0_180.range = ran_val_csch_0_180;
	
	Inclinations.angle_0_90.range   = ran_val_ang_0_90;
    Inclinations.sin_0_90.range   = ran_val_sin_0_90;
    Inclinations.cos_0_90.range   = ran_val_cos_0_90;
    Inclinations.tan_0_90.range   = ran_val_tan_0_90;
    Inclinations.sec_0_90.range   = ran_val_sec_0_90;
    Inclinations.cot_0_90.range   = ran_val_cot_0_90;
    Inclinations.csc_0_90.range   = ran_val_csc_0_90;
    Inclinations.sinh_0_90.range  = ran_val_sinh_0_90;
    Inclinations.cosh_0_90.range  = ran_val_cosh_0_90;
    Inclinations.tanh_0_90.range  = ran_val_tanh_0_90;
    Inclinations.sech_0_90.range  = ran_val_sech_0_90;
    Inclinations.coth_0_90.range  = ran_val_coth_0_90;
    Inclinations.csch_0_90.range  = ran_val_csch_0_90;
	
    
    %Percentils for each norm
    Inclinations.angle_0_360.percentils     = per_val_ang_0_360;
    Inclinations.sin_0_360.percentils     = per_val_sin_0_360;
    Inclinations.cos_0_360.percentils     = per_val_cos_0_360;
    Inclinations.tan_0_360.percentils     = per_val_tan_0_360;
    Inclinations.sec_0_360.percentils     = per_val_sec_0_360;
    Inclinations.cot_0_360.percentils     = per_val_cot_0_360;
    Inclinations.csc_0_360.percentils     = per_val_csc_0_360;
    Inclinations.sinh_0_360.percentils    = per_val_sinh_0_360;
    Inclinations.cosh_0_360.percentils    = per_val_cosh_0_360;
    Inclinations.tanh_0_360.percentils    = per_val_tanh_0_360;
    Inclinations.sech_0_360.percentils    = per_val_sech_0_360;
    Inclinations.coth_0_360.percentils    = per_val_coth_0_360;
    Inclinations.csch_0_360.percentils    = per_val_csch_0_360;
	
	Inclinations.angle_0_180.percentils     = per_val_ang_0_180;
    Inclinations.sin_0_180.percentils     = per_val_sin_0_180;
    Inclinations.cos_0_180.percentils     = per_val_cos_0_180;
    Inclinations.tan_0_180.percentils     = per_val_tan_0_180;
    Inclinations.sec_0_180.percentils     = per_val_sec_0_180;
    Inclinations.cot_0_180.percentils     = per_val_cot_0_180;
    Inclinations.csc_0_180.percentils     = per_val_csc_0_180;
    Inclinations.sinh_0_180.percentils    = per_val_sinh_0_180;
    Inclinations.cosh_0_180.percentils    = per_val_cosh_0_180;
    Inclinations.tanh_0_180.percentils    = per_val_tanh_0_180;
    Inclinations.sech_0_180.percentils    = per_val_sech_0_180;
    Inclinations.coth_0_180.percentils    = per_val_coth_0_180;
    Inclinations.csch_0_180.percentils    = per_val_csch_0_180;
	
	Inclinations.angle_0_90.percentils      = per_val_ang_0_90;
    Inclinations.sin_0_90.percentils      = per_val_sin_0_90;
    Inclinations.cos_0_90.percentils      = per_val_cos_0_90;
    Inclinations.tan_0_90.percentils      = per_val_tan_0_90;
    Inclinations.sec_0_90.percentils      = per_val_sec_0_90;
    Inclinations.cot_0_90.percentils      = per_val_cot_0_90;
    Inclinations.csc_0_90.percentils      = per_val_csc_0_90;
    Inclinations.sinh_0_90.percentils     = per_val_sinh_0_90;
    Inclinations.cosh_0_90.percentils     = per_val_cosh_0_90;
    Inclinations.tanh_0_90.percentils     = per_val_tanh_0_90;
    Inclinations.sech_0_90.percentils     = per_val_sech_0_90;
    Inclinations.coth_0_90.percentils     = per_val_coth_0_90;
    Inclinations.csch_0_90.percentils     = per_val_csch_0_90;

	
	%Skewness for each norm
    Inclinations.angle_0_360.skewness     = skew_val_ang_0_360;
    Inclinations.sin_0_360.skewness     = skew_val_sin_0_360;
    Inclinations.cos_0_360.skewness     = skew_val_cos_0_360;
    Inclinations.tan_0_360.skewness     = skew_val_tan_0_360;
    Inclinations.sec_0_360.skewness     = skew_val_sec_0_360;
    Inclinations.cot_0_360.skewness     = skew_val_cot_0_360;
    Inclinations.csc_0_360.skewness     = skew_val_csc_0_360;
    Inclinations.sinh_0_360.skewness    = skew_val_sinh_0_360;
    Inclinations.cosh_0_360.skewness    = skew_val_cosh_0_360;
    Inclinations.tanh_0_360.skewness    = skew_val_tanh_0_360;
    Inclinations.sech_0_360.skewness    = skew_val_sech_0_360;
    Inclinations.coth_0_360.skewness    = skew_val_coth_0_360;
    Inclinations.csch_0_360.skewness    = skew_val_csch_0_360;
	
	Inclinations.angle_0_180.skewness     = skew_val_ang_0_180;
    Inclinations.sin_0_180.skewness     = skew_val_sin_0_180;
    Inclinations.cos_0_180.skewness     = skew_val_cos_0_180;
    Inclinations.tan_0_180.skewness     = skew_val_tan_0_180;
    Inclinations.sec_0_180.skewness     = skew_val_sec_0_180;
    Inclinations.cot_0_180.skewness     = skew_val_cot_0_180;
    Inclinations.csc_0_180.skewness     = skew_val_csc_0_180;
    Inclinations.sinh_0_180.skewness    = skew_val_sinh_0_180;
    Inclinations.cosh_0_180.skewness    = skew_val_cosh_0_180;
    Inclinations.tanh_0_180.skewness    = skew_val_tanh_0_180;
    Inclinations.sech_0_180.skewness    = skew_val_sech_0_180;
    Inclinations.coth_0_180.skewness    = skew_val_coth_0_180;
    Inclinations.csch_0_180.skewness    = skew_val_csch_0_180;
	
	Inclinations.angle_0_90.skewness      = skew_val_ang_0_90;
    Inclinations.sin_0_90.skewness      = skew_val_sin_0_90;
    Inclinations.cos_0_90.skewness      = skew_val_cos_0_90;
    Inclinations.tan_0_90.skewness      = skew_val_tan_0_90;
    Inclinations.sec_0_90.skewness      = skew_val_sec_0_90;
    Inclinations.cot_0_90.skewness      = skew_val_cot_0_90;
    Inclinations.csc_0_90.skewness      = skew_val_csc_0_90;
    Inclinations.sinh_0_90.skewness     = skew_val_sinh_0_90;
    Inclinations.cosh_0_90.skewness     = skew_val_cosh_0_90;
    Inclinations.tanh_0_90.skewness     = skew_val_tanh_0_90;
    Inclinations.sech_0_90.skewness     = skew_val_sech_0_90;
    Inclinations.coth_0_90.skewness     = skew_val_coth_0_90;
    Inclinations.csch_0_90.skewness     = skew_val_csch_0_90;
    
	
	
    %Kurtosis for each norm
    Inclinations.angle_0_360.kurtosis     = kurt_val_ang_0_360;
    Inclinations.sin_0_360.kurtosis     = kurt_val_sin_0_360;
    Inclinations.cos_0_360.kurtosis     = kurt_val_cos_0_360;
    Inclinations.tan_0_360.kurtosis     = kurt_val_tan_0_360;
    Inclinations.sec_0_360.kurtosis     = kurt_val_sec_0_360;
    Inclinations.cot_0_360.kurtosis     = kurt_val_cot_0_360;
    Inclinations.csc_0_360.kurtosis     = kurt_val_csc_0_360;
    Inclinations.sinh_0_360.kurtosis    = kurt_val_sinh_0_360;
    Inclinations.cosh_0_360.kurtosis    = kurt_val_cosh_0_360;
    Inclinations.tanh_0_360.kurtosis    = kurt_val_tanh_0_360;
    Inclinations.sech_0_360.kurtosis    = kurt_val_sech_0_360;
    Inclinations.coth_0_360.kurtosis    = kurt_val_coth_0_360;
    Inclinations.csch_0_360.kurtosis    = kurt_val_csch_0_360;
	
	Inclinations.angle_0_180.kurtosis     = kurt_val_ang_0_180;
    Inclinations.sin_0_180.kurtosis     = kurt_val_sin_0_180;
    Inclinations.cos_0_180.kurtosis     = kurt_val_cos_0_180;
    Inclinations.tan_0_180.kurtosis     = kurt_val_tan_0_180;
    Inclinations.sec_0_180.kurtosis     = kurt_val_sec_0_180;
    Inclinations.cot_0_180.kurtosis     = kurt_val_cot_0_180;
    Inclinations.csc_0_180.kurtosis     = kurt_val_csc_0_180;
    Inclinations.sinh_0_180.kurtosis    = kurt_val_sinh_0_180;
    Inclinations.cosh_0_180.kurtosis    = kurt_val_cosh_0_180;
    Inclinations.tanh_0_180.kurtosis    = kurt_val_tanh_0_180;
    Inclinations.sech_0_180.kurtosis    = kurt_val_sech_0_180;
    Inclinations.coth_0_180.kurtosis    = kurt_val_coth_0_180;
    Inclinations.csch_0_180.kurtosis    = kurt_val_csch_0_180;
	
	Inclinations.angle_0_90.kurtosis      = kurt_val_ang_0_90;
    Inclinations.sin_0_90.kurtosis      = kurt_val_sin_0_90;
    Inclinations.cos_0_90.kurtosis      = kurt_val_cos_0_90;
    Inclinations.tan_0_90.kurtosis      = kurt_val_tan_0_90;
    Inclinations.sec_0_90.kurtosis      = kurt_val_sec_0_90;
    Inclinations.cot_0_90.kurtosis      = kurt_val_cot_0_90;
    Inclinations.csc_0_90.kurtosis      = kurt_val_csc_0_90;
    Inclinations.sinh_0_90.kurtosis     = kurt_val_sinh_0_90;
    Inclinations.cosh_0_90.kurtosis     = kurt_val_cosh_0_90;
    Inclinations.tanh_0_90.kurtosis     = kurt_val_tanh_0_90;
    Inclinations.sech_0_90.kurtosis     = kurt_val_sech_0_90;
    Inclinations.coth_0_90.kurtosis     = kurt_val_coth_0_90;
    Inclinations.csch_0_90.kurtosis     = kurt_val_csch_0_90;
	
	
    
end