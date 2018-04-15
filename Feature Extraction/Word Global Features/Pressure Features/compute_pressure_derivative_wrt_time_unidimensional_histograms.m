function [ Pressure_T_Derivative ] = compute_pressure_derivative_wrt_time_unidimensional_histograms( Word , word_type , n_bins , delimiters_type , hist_type )
%% compute_pressure_derivative_wrt_time_unidimensional_histograms
%  Computes all the unidimensional histograms parameters on a word pressure
%  Mean, Std, Min, Max, Range, Percentils (steps of 5%) 
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Pressure_T_Derivative_ ] = _*compute_pressure_derivative_wrt_time_unidimensional_histograms*_ ( _Word_ , _word_type_ , _n_bins_ , _delimiters_type_ , _hist_type_ )
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
% * *Pressure_T_Derivative*  : A struct containing all the bin parameters.
%
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
    [ dp_dt_val , ~ , ~ ] = compute_valid_pressure_derivatives(iWord);
    
    bin_loader = strcat('Bin_Delimiters_Pressure_T_Derivative_',word_type,'_',num2str(n_bins),'bins');
    eval(bin_loader);    
    
    delimiters = eval(strcat('Bins.Pressure_T_Derivative.',word_type,'.Bins',num2str(n_bins),'.',delimiters_type));
    Pressure_T_Derivative  = a_good_histogram_function( dp_dt_val , delimiters , hist_type );
   
    
end