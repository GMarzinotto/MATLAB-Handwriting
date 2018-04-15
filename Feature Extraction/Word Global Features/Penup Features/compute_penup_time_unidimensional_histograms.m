function [ Penups ] = compute_penup_time_unidimensional_histograms( Word, n_bins , delimiters_type , hist_type )
%% compute_penup_time_unidimensional_histograms
%  Computes all the unidimensional histogram on a word penup
%  times. Mean, Std, Min, Max, Range, Percentils (steps of 5%) 
%  Input word_type is kept as a template, even if it is not used
%
%
% [ _Penups_ ] = _*compute_penup_time_unidimensional_histograms*_ ( _Word_ , _n_bins_ , _delimiters_type_ , _hist_type_  )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *n_bins*    : Number of bins for the quantification
%
% * *delimiters_type* : type of delimiters estimators to be used. 
%                       Either 'Percentils' , 'Uniform' , 'Quantification'
%
% * *hist_type* : Type of histogram to be used, either 'Basic' or 'Parzen'
%
%%% Outputs
% 
% * *Penups*  : A struct containing all the unidim. statistics parameters.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (July 2016)
%  Modified by: ---
%%
    
    penup_times  = compute_all_penup_times(Word);
    
     
    bin_loader = strcat('Bin_Delimiters_Penup_Time_',num2str(n_bins),'bins');
    eval(bin_loader);
    
    
    delimiters = eval(strcat('Bins.Penup_Time.Bins',num2str(n_bins),'.',delimiters_type));
    Penups  = a_good_histogram_function( penup_times , delimiters , hist_type );
    

    
end