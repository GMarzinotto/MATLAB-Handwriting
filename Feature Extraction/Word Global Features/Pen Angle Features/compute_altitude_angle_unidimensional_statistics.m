function [ Altitude_Angle ] = compute_altitude_angle_unidimensional_statistics( Word , word_type )
%% compute_altitude_angle_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on altitude angle
%  time durations. Mean, Std, Min, Max, Range, Percentils (steps of 5%)
%  user must also provide an input specifiying which strokes should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Altitude_Angle_ ] = _*compute_altitude_angle_unidimensional_statistics*_ ( _Word_ , _word_type_ )
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
% * *Altitude_Angle*  : A struct containing all the parameters.
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if(nargin < 2)
        word_type = 'ON_TABLET';
    end
    
    iWord = convert_word_to_a_new_tracking_type(Word,word_type);
    if( ~isempty(iWord) )
        [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , skew_kurt ] = compute_unidimensional_statistics(iWord.Al);    
    else
        [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , skew_kurt ] = compute_unidimensional_statistics([]);  
    end
    
    Altitude_Angle.mean       = avg_val;
    Altitude_Angle.std        = std_val;
    Altitude_Angle.min        = min_val;
    Altitude_Angle.max        = max_val;
    Altitude_Angle.range      = ran_val;
    Altitude_Angle.percentils = per_val;
    Altitude_Angle.skewness   = skew_val;
    Altitude_Angle.kurtosis   = skew_kurt;
   
    
end