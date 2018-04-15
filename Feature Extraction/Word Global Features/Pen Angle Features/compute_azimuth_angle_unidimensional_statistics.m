function [ Azimuth_Angle ] = compute_azimuth_angle_unidimensional_statistics( Word , word_type )
%% compute_azimuth_angle_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on azimuth angle
%  time durations. Mean, Std, Min, Max, Range, Percentils (steps of 5%)
%  user must also provide an input specifiying which strokes should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Azimuth_Angle_ ] = _*compute_azimuth_angle_unidimensional_statistics*_ ( _Word_ , _word_type_ )
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
% * *Azimuth_Angle*  : A struct containing all the parameters, organized first in
%                      the norm used, and then in the statistic parameter
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
    
    if(~isempty(iWord))
        [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , skew_kurt ] = compute_unidimensional_statistics(iWord.Az);    
    else
        [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , skew_kurt ] = compute_unidimensional_statistics([]);
    end
    
    Azimuth_Angle.mean       = avg_val;
    Azimuth_Angle.std        = std_val;
    Azimuth_Angle.min        = min_val;
    Azimuth_Angle.max        = max_val;
    Azimuth_Angle.range      = ran_val;
    Azimuth_Angle.percentils = per_val;
    Azimuth_Angle.skewness   = skew_val;
    Azimuth_Angle.kurtosis   = skew_kurt;
   
    
end