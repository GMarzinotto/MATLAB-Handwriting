function [ Penups ] = compute_penup_time_unidimensional_statistics(Word)
%% compute_penup_time_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on a word penup
%  times. Mean, Std, Min, Max, Range, Percentils (steps of 5%) 
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%  for this particular feature ON_TABLET, ON_AIR, ON_TABLET_ON_AIR 
%  produce the same output.
%
%
% [ _Penups_ ] = _*compute_penup_time_unidimensional_statistics*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *Penups*  : A struct containing all the unidim. statistics parameters.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%
    
    penup_times  = compute_all_penup_times(Word);
    
    [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , kurt_val ] = compute_unidimensional_statistics(penup_times);

    Penups.mean       = avg_val;
    Penups.std        = std_val;
    Penups.min        = min_val;
    Penups.max        = max_val;
    Penups.range      = ran_val;
    Penups.percentils = per_val;
    Penups.skewness   = skew_val;
    Penups.kurtosis   = kurt_val;
    
    
end