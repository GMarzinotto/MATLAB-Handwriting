function [ Pressure ] = compute_pressure_unidimensional_statistics(Word,word_type)
%% compute_pressure_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on a word pressure
%  Mean, Std, Min, Max, Range, Percentils (steps of 5%) 
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Pressure_ ] = _*compute_pressure_unidimensional_statistics*_ ( _Word_ , _word_type_ )
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
% * *Pressure*  : A struct containing all the parameters, organized first in
%                 the norm used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);
    
    [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , kurt_val ] = compute_unidimensional_statistics(iWord.P);

    Pressure.mean       = avg_val;
    Pressure.std        = std_val;
    Pressure.min        = min_val;
    Pressure.max        = max_val;
    Pressure.range      = ran_val;
    Pressure.percentils = per_val;
    Pressure.skewness   = skew_val;
    Pressure.kurtosis   = kurt_val;
    
    
end