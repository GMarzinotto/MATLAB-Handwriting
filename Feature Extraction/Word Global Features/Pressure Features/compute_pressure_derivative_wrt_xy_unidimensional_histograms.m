function [ Pressure_XY_Derivative ] = compute_pressure_derivative_wrt_xy_unidimensional_histograms( Word , word_type , n_bins , delimiters_type , hist_type )
%% compute_pressure_derivative_wrt_xy_unidimensional_histograms
%  Computes all the unidimensional histograms parameters on a word pressure
%  Mean, Std, Min, Max, Range, Percentils (steps of 5%) 
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Pressure_XY_Derivative_ ] = _*compute_pressure_derivative_wrt_xy_unidimensional_histograms*_ ( _Word_ , _word_type_ , _n_bins_ , _delimiters_type_ , _hist_type_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
% * *n_bins*    : Number of bins for the quantification
%
% * *delimiters_type* : type of delimiters estimators to be used. 
%                       Either 'Percentils' , 'Uniform' , 'Quantification'
%
% * *hist_type* : Type of histogram to be used, either 'Basic' or 'Parzen'
%
%
%%% Outputs
% 
% * *Pressure_XY_Derivative*  : A struct containing all the parameters, 
%                               organized first in the norm used,
%                               and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (July 2016)
%  Modified by: ---
%%

    if(strcmp('ON_AIR',word_type))
       error('There is no point in computing the histograms of pressure using the Air trajectories, the pressures are all zero...')
    end

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);
    
    [ ~ , dp_dx_val , dp_dy_val ] = compute_valid_pressure_derivatives(iWord); 
    [norm_l2 , norm_l1 , norm_linf , norm_linfn , abs_x , abs_y ] = compute_all_norms(dp_dx_val , dp_dy_val);
    
    bin_loader = strcat('Bin_Delimiters_Pressure_XY_Derivative_',word_type,'_',num2str(n_bins),'bins');
    eval(bin_loader);    
      
    delimiters_x = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.X.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_x  = a_good_histogram_function( dp_dx_val , delimiters_x , hist_type );
    
    delimiters_y = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.Y.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_y  = a_good_histogram_function( dp_dy_val , delimiters_y , hist_type );
    
    delimiters_abs_x = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.absX.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_abs_x  = a_good_histogram_function( abs_x , delimiters_abs_x , hist_type );
    
    delimiters_abs_y = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.absY.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_abs_y  = a_good_histogram_function( abs_y , delimiters_abs_y , hist_type );
    
    delimiters_l2 = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.L2.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_l2  = a_good_histogram_function( norm_l2 , delimiters_l2 , hist_type );
    
    delimiters_l1 = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.L1.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_l1  = a_good_histogram_function( norm_l1 , delimiters_l1 , hist_type );
    
    delimiters_linf = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.Li.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_linf  = a_good_histogram_function( norm_linf , delimiters_linf , hist_type );
    
    delimiters_linfn = eval(strcat('Bins.Pressure_XY_Derivative.',word_type,'.Lin.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_linfn  = a_good_histogram_function( norm_linfn , delimiters_linfn , hist_type );
    
    %Mean Values for each norm
    Pressure_XY_Derivative.L2    = histogram_l2;
    Pressure_XY_Derivative.L1    = histogram_l1;
    Pressure_XY_Derivative.Linf  = histogram_linf;
    Pressure_XY_Derivative.Linfn = histogram_linfn;
    Pressure_XY_Derivative.Xabs  = histogram_abs_x;
    Pressure_XY_Derivative.Yabs  = histogram_abs_y;
    Pressure_XY_Derivative.X     = histogram_x;
    Pressure_XY_Derivative.Y     = histogram_y;
    
end