function [ Acceleration ] = compute_acceleration_unidimensional_histograms( Word , word_type , n_bins , delimiters_type , hist_type )
%% compute_acceleration_unidimensional_histograms
%  Computes all the histogram parameters on a word acceleration
%  this is done using all the standard norms and raw values
%  (L1, L2, Linf, Linfn, AbsX, AbsY, X, Y)
%  user must also provide an input specifiying which acceleration should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%  This function may crash if the delimiters are not previously estimated
%  and stored in the path.
%
%
% [ _Acceleration_ ] = _*compute_acceleration_unidimensional_histograms*_ ( _Word_ , _word_type_ , _n_bins_ , _delimiters_type_ , _hist_type_ )
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
% * *Acceleration*  : A struct containing all the parameters, organized first in
%                     the norm used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if(nargin < 2)
        word_type = 'ON_TABLET';
    end
    if(nargin < 3)
        n_bins = 4;
    end
    if(nargin < 4)
        delimiters_type = 'Quantification';
    end
    if(nargin < 5)
        hist_type = 'Basic';
    end

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    [ ~ , ax_val , ay_val ] = compute_valid_accelerations(iWord);

    [ norm_l2 , norm_l1 , norm_linf , norm_linfn , abs_x , abs_y ] = compute_all_norms( ax_val , ay_val );
    
    bin_loader = strcat('Bin_Delimiters_Acceleration_',word_type,'_',num2str(n_bins),'bins');
    eval(bin_loader);
    
    
    delimiters_x = eval(strcat('Bins.Acceleration.',word_type,'.X.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_x  = a_good_histogram_function( ax_val , delimiters_x , hist_type );
    
    delimiters_y = eval(strcat('Bins.Acceleration.',word_type,'.Y.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_y  = a_good_histogram_function( ay_val , delimiters_y , hist_type );
    
    delimiters_abs_x = eval(strcat('Bins.Acceleration.',word_type,'.absX.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_abs_x  = a_good_histogram_function( abs_x , delimiters_abs_x , hist_type );
    
    delimiters_abs_y = eval(strcat('Bins.Acceleration.',word_type,'.absY.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_abs_y  = a_good_histogram_function( abs_y , delimiters_abs_y , hist_type );
    
    delimiters_l2 = eval(strcat('Bins.Acceleration.',word_type,'.L2.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_l2  = a_good_histogram_function( norm_l2 , delimiters_l2 , hist_type );
    
    delimiters_l1 = eval(strcat('Bins.Acceleration.',word_type,'.L1.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_l1  = a_good_histogram_function( norm_l1 , delimiters_l1 , hist_type );
    
    delimiters_linf = eval(strcat('Bins.Acceleration.',word_type,'.Li.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_linf  = a_good_histogram_function( norm_linf , delimiters_linf , hist_type );
    
    delimiters_linfn = eval(strcat('Bins.Acceleration.',word_type,'.Lin.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_linfn  = a_good_histogram_function( norm_linfn , delimiters_linfn , hist_type );
    
    %Mean Values for each norm
    Acceleration.L2    = histogram_l2;
    Acceleration.L1    = histogram_l1;
    Acceleration.Linf  = histogram_linf;
    Acceleration.Linfn = histogram_linfn;
    Acceleration.Xabs  = histogram_abs_x;
    Acceleration.Yabs  = histogram_abs_y;
    Acceleration.X     = histogram_x;
    Acceleration.Y     = histogram_y;
    
    
end