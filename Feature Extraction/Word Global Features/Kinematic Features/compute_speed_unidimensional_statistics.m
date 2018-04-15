function [ Speed ] = compute_speed_unidimensional_statistics(Word,word_type)
%% compute_speed_unidimensional_statistics
%  Computes all the unidimensional statistics parameters on a word speed
%  Mean, Std, Min, Max, Range, Percentils (steps of 5%) this is done using
%  all the standard norms and raw values (L1, L2, Linf, AbsX, AbsY, X, Y)
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Speed_ ] = _*compute_speed_unidimensional_statistics*_ ( _Word_ , _word_type_ )
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
% * *Speed*  : A struct containing all the parameters, organized first in
%              the norm used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    if(nargin < 2)
        word_type = 'ON_TABLET';
    end
    
    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    [ ~ , vx_val , vy_val ] = compute_valid_speeds(iWord);

    [norm_l2 , norm_l1 , norm_linf , norm_linfn , abs_x , abs_y ] = compute_all_norms(vx_val , vy_val);
    
    [avg_val_l2  , std_val_l2  , min_val_l2  , max_val_l2  , ran_val_l2  , per_val_l2  , skew_val_l2  , kurt_val_l2 ]  = compute_unidimensional_statistics(norm_l2);
    [avg_val_l1  , std_val_l1  , min_val_l1  , max_val_l1  , ran_val_l1  , per_val_l1  , skew_val_l1  , kurt_val_l1 ]  = compute_unidimensional_statistics(norm_l1);
    [avg_val_li  , std_val_li  , min_val_li  , max_val_li  , ran_val_li  , per_val_li  , skew_val_li  , kurt_val_li ]  = compute_unidimensional_statistics(norm_linf);
    [avg_val_lin , std_val_lin , min_val_lin , max_val_lin , ran_val_lin , per_val_lin , skew_val_lin , kurt_val_lin ] = compute_unidimensional_statistics(norm_linfn);

    [avg_val_x_abs , std_val_x_abs , min_val_x_abs , max_val_x_abs , ran_val_x_abs , per_val_x_abs , skew_val_x_abs , kurt_val_x_abs ] = compute_unidimensional_statistics(abs_x);
    [avg_val_y_abs , std_val_y_abs , min_val_y_abs , max_val_y_abs , ran_val_y_abs , per_val_y_abs , skew_val_y_abs , kurt_val_y_abs ] = compute_unidimensional_statistics(abs_y);
    
    [avg_val_x , std_val_x , min_val_x , max_val_x , ran_val_x , per_val_x , skew_val_x , kurt_val_x ] = compute_unidimensional_statistics(vx_val);
    [avg_val_y , std_val_y , min_val_y , max_val_y , ran_val_y , per_val_y , skew_val_y , kurt_val_y ] = compute_unidimensional_statistics(vy_val);
    
    %Mean Values for each norm
    Speed.L2.mean   = avg_val_l2;
    Speed.L1.mean   = avg_val_l1;
    Speed.Linf.mean = avg_val_li;
    Speed.Linfn.mean = avg_val_lin;
    Speed.Xabs.mean = avg_val_x_abs;
    Speed.Yabs.mean = avg_val_y_abs;
    Speed.X.mean    = avg_val_x;
    Speed.Y.mean    = avg_val_y;
    
    %Standard Deviation for each norm
    Speed.L2.std   = std_val_l2;
    Speed.L1.std   = std_val_l1;
    Speed.Linf.std = std_val_li;
    Speed.Linfn.std = std_val_lin;
    Speed.Xabs.std = std_val_x_abs;
    Speed.Yabs.std = std_val_y_abs;
    Speed.X.std    = std_val_x;
    Speed.Y.std    = std_val_y;
    
    %Minimum value for each norm
    Speed.L2.min   = min_val_l2;
    Speed.L1.min   = min_val_l1;
    Speed.Linf.min = min_val_li;
    Speed.Linfn.min = min_val_lin;
    Speed.Xabs.min = min_val_x_abs;
    Speed.Yabs.min = min_val_y_abs;
    Speed.X.min    = min_val_x;
    Speed.Y.min    = min_val_y;
    
    %Maximum value for each norm
    Speed.L2.max   = max_val_l2;
    Speed.L1.max   = max_val_l1;
    Speed.Linf.max = max_val_li;
    Speed.Linfn.max = max_val_lin;
    Speed.Xabs.max = max_val_x_abs;
    Speed.Yabs.max = max_val_y_abs;
    Speed.X.max    = max_val_x;
    Speed.Y.max    = max_val_y;
    
    %Range for each norm
    Speed.L2.range   = ran_val_l2;
    Speed.L1.range   = ran_val_l1;
    Speed.Linf.range = ran_val_li;
    Speed.Linfn.range = ran_val_lin;
    Speed.Xabs.range = ran_val_x_abs;
    Speed.Yabs.range = ran_val_y_abs;
    Speed.X.range    = ran_val_x;
    Speed.Y.range    = ran_val_y;
    
    %Percentils for each norm
    Speed.L2.percentils   = per_val_l2;
    Speed.L1.percentils   = per_val_l1;
    Speed.Linf.percentils = per_val_li;
    Speed.Linfn.percentils = per_val_lin;
    Speed.Xabs.percentils = per_val_x_abs;
    Speed.Yabs.percentils = per_val_y_abs;
    Speed.X.percentils    = per_val_x;
    Speed.Y.percentils    = per_val_y;
    
    %Skewness for each norm
    Speed.L2.skewness   = skew_val_l2;
    Speed.L1.skewness   = skew_val_l1;
    Speed.Linf.skewness = skew_val_li;
    Speed.Linfn.skewness = skew_val_lin;
    Speed.Xabs.skewness = skew_val_x_abs;
    Speed.Yabs.skewness = skew_val_y_abs;
    Speed.X.skewness    = skew_val_x;
    Speed.Y.skewness    = skew_val_y;
    
    %Kurtosis for each norm
    Speed.L2.kurtosis   = kurt_val_l2;
    Speed.L1.kurtosis   = kurt_val_l1;
    Speed.Linf.kurtosis = kurt_val_li;
    Speed.Linfn.kurtosis = kurt_val_lin;
    Speed.Xabs.kurtosis = kurt_val_x_abs;
    Speed.Yabs.kurtosis = kurt_val_y_abs;
    Speed.X.kurtosis    = kurt_val_x;
    Speed.Y.kurtosis    = kurt_val_y;
    
end