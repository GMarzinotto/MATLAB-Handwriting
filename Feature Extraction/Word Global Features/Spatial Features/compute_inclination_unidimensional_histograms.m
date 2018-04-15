function [ Inclination ] = compute_inclination_unidimensional_histograms( Word , word_type , n_bins , delimiters_type , hist_type )
%% compute_inclination_unidimensional_histograms
%  Computes all the histograms parameters on a word inclination
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Inclination_ ] = _*compute_inclination_unidimensional_histograms*_ ( _Word_ , _word_type_ , _n_bins_ , _delimiters_type_ , _hist_type_ )
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
% * *Inclination*  : A struct containing all the histogram parameters
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (July 2016)
%  Modified by: ---
%%

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);
    
    bin_loader = strcat('Bin_Delimiters_Inclination_',word_type,'_',num2str(n_bins),'bins');
    eval(bin_loader);    
    
    [ angle_deg_0_360 , angle_deg_0_180 , angle_deg_0_90 ] = compute_valid_inclinations(iWord);
    
    delimiters = eval(strcat('Bins.Inclination.',word_type,'.angle_0_90.Bins',num2str(n_bins),'.',delimiters_type));
    Inclination.angle_0_90  = a_good_histogram_function( angle_deg_0_90  , delimiters , hist_type );
    
    delimiters = eval(strcat('Bins.Inclination.',word_type,'.angle_0_180.Bins',num2str(n_bins),'.',delimiters_type));
    Inclination.angle_0_180 = a_good_histogram_function( angle_deg_0_180  , delimiters , hist_type );
    
    delimiters = eval(strcat('Bins.Inclination.',word_type,'.angle_0_360.Bins',num2str(n_bins),'.',delimiters_type));
    Inclination.angle_0_360 = a_good_histogram_function( angle_deg_0_360  , delimiters , hist_type );
   
    
end