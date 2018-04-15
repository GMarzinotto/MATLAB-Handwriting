function [ Box_Spacing ] = compute_horizontal_box_spacing_unidimensional_statistics( Word )
%% compute_horizontal_box_spacing_unidimensional_statistics
%  Computes all the unidimensional histogram on a word box spaces
%
%
% [ _Box_Spacing_ ] = _*compute_horizontal_box_spacing_unidimensional_statistics*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%
%%% Outputs
% 
% * *Box_Spacing*  : A struct containing all the unidim. statistics parameters.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (September 2016)
%  Modified by: ---
%%

    space_size_cm  = compute_horizontal_box_spacing( Word );

         
    [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , kurt_val ] = compute_unidimensional_statistics( space_size_cm );

    Box_Spacing.mean       = avg_val;
    Box_Spacing.std        = std_val;
    Box_Spacing.min        = min_val;
    Box_Spacing.max        = max_val;
    Box_Spacing.range      = ran_val;
    Box_Spacing.percentils = per_val;
    Box_Spacing.skewness   = skew_val;
    Box_Spacing.kurtosis   = kurt_val;
    

end