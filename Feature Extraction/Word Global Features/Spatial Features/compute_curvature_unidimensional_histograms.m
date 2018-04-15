function [ Curvature ] = compute_curvature_unidimensional_histograms( Word , word_type , window_size , n_bins , delimiters_type , hist_type )
%% compute_curvature_unidimensional_histograms
%  Computes all the histograms parameters on a word curvature
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Curvature_ ] = _*compute_curvature_unidimensional_histograms*_ ( _Word_ , _word_type_ , window_size , _n_bins_ , _delimiters_type_ , _hist_type_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
% * *window_size* : Size of the window to compute the curvature angle
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
% * *Curvature*  : A struct containing all the histogram parameters
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (July 2016)
%  Modified by: ---
%%

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);
    
    bin_loader = strcat('Bin_Delimiters_Curvature_Window_Size_',num2str(window_size),'_',word_type,'_',num2str(n_bins),'bins');
    eval(bin_loader);    

    curvature_vals = compute_valid_curvatures(iWord , window_size );
    delimiters = eval(strcat('Bins.Curvature_Window_Size_',num2str(window_size),'.',word_type,'.angle_0_180.Bins',num2str(n_bins),'.',delimiters_type));
 
    
%     if(iWord.NumSamples > 2*window_size + 1)
     Curvature.angle_0_180 = a_good_histogram_function( curvature_vals , delimiters , hist_type );

%     end
    
end