function [ Penup_Spacing ] = compute_horizontal_penup_spacing_unidimensional_statistics( Word )
%% compute_horizontal_penup_spacing_unidimensional_statistics
%  Computes all the unidimensional statistics on a word penup
%  horizontal spacing. 
%
%
% [ _Penups_ ] = _*compute_horizontal_penup_spacing_unidimensional_statistics*_ ( _Word_ , _n_bins_ , _delimiters_type_ , _hist_type_  )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%
%%% Outputs
% 
% * *Penup_Spacing*  : A struct containing all the histogram features.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (September 2016)
%  Modified by: ---
%%

    space_size_cm  = compute_horizontal_penup_spacing( Word );

    [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , kurt_val ] = compute_unidimensional_statistics( space_size_cm );

    Penup_Spacing.mean       = avg_val;
    Penup_Spacing.std        = std_val;
    Penup_Spacing.min        = min_val;
    Penup_Spacing.max        = max_val;
    Penup_Spacing.range      = ran_val;
    Penup_Spacing.percentils = per_val;
    Penup_Spacing.skewness   = skew_val;
    Penup_Spacing.kurtosis   = kurt_val;


end