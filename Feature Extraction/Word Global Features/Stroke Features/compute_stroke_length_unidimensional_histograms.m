function [ Stroke_Lengths ] = compute_stroke_length_unidimensional_histograms( Word , word_type , stroke_criterion , n_bins , delimiters_type , hist_type )
%% compute_stroke_length_unidimensional_histograms
%  Computes all the histograms parameters on a word stroke length
%  user must also provide an input specifiying which speed should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%
%
% [ _Stroke_Lengths_ ] = _*compute_stroke_length_unidimensional_histograms*_ ( _Word_ , _word_type_ , stroke_criterion , _n_bins_ , _delimiters_type_ , _hist_type_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
% * *stroke_criterion* : Stroke segmentation criterion. There are 4 types:
%                        'PENUP_CRITERION' , 'VY_CRITERION' , 
%                        'VX_CRITERION' , 'VX_VY_CRITERION'
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
% * *Stroke_Lengths*  : A struct containing all the histogram parameters
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (July 2016)
%  Modified by: ---
%%

    iWord = convert_word_to_a_new_tracking_type(Word,word_type);
    
    bin_loader = strcat('Bin_Delimiters_Stroke_Lengths_',stroke_criterion,'_',word_type,'_',num2str(n_bins),'bins');
    eval(bin_loader);    
    
    [ ~ , x_val , y_val ] = compute_strokes_lengths( iWord , word_type , stroke_criterion );
    [ norm_l2 , norm_l1 , norm_linf , norm_linfn , abs_x , abs_y ] = compute_all_norms( x_val , y_val );
    
   
    delimiters_x = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.X.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_x  = a_good_histogram_function( x_val , delimiters_x , hist_type );
    
    delimiters_y = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.Y.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_y  = a_good_histogram_function( y_val , delimiters_y , hist_type );
    
    delimiters_abs_x = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.absX.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_abs_x  = a_good_histogram_function( abs_x , delimiters_abs_x , hist_type );
    
    delimiters_abs_y = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.absY.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_abs_y  = a_good_histogram_function( abs_y , delimiters_abs_y , hist_type );
    
    delimiters_l2 = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.L2.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_l2  = a_good_histogram_function( norm_l2 , delimiters_l2 , hist_type );
    
    delimiters_l1 = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.L1.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_l1  = a_good_histogram_function( norm_l1 , delimiters_l1 , hist_type );
    
    delimiters_linf = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.Li.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_linf  = a_good_histogram_function( norm_linf , delimiters_linf , hist_type );
    
    delimiters_linfn = eval(strcat('Bins.Stroke_Lengths_',stroke_criterion,'.',word_type,'.Lin.Bins',num2str(n_bins),'.',delimiters_type));
    histogram_linfn  = a_good_histogram_function( norm_linfn , delimiters_linfn , hist_type );
    
    %Mean Values for each norm
    Stroke_Lengths.L2    = histogram_l2;
    Stroke_Lengths.L1    = histogram_l1;
    Stroke_Lengths.Linf  = histogram_linf;
    Stroke_Lengths.Linfn = histogram_linfn;
    Stroke_Lengths.Xabs  = histogram_abs_x;
    Stroke_Lengths.Yabs  = histogram_abs_y;
    Stroke_Lengths.X     = histogram_x;
    Stroke_Lengths.Y     = histogram_y;
    
end