function [ Altitude_Angle ] = compute_altitude_angle_unidimensional_histograms( Word , word_type , n_bins , delimiters_type , hist_type )
%% compute_altitude_angle_unidimensional_histograms
%  Computes all the unidimensional histogram on altitude angle
%  time durations. Mean, Std, Min, Max, Range, Percentils (steps of 5%)
%  user must also provide an input specifiying which strokes should be
%  considered, ON_TABLET, ON_AIR, ON_TABLET_ON_AIR
%  This function may crash if the delimiters are not previously estimated
%  and stored in the path.
%
%
% [ _Altitude_Angle_ ] = _*compute_altitude_angle_unidimensional_histograms*_ ( _Word_ , _word_type_ , _n_bins_ , _delimiters_type_ , _hist_type_ )
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
% * *Altitude_Angle*  : A struct containing all the parameters, organized first in
%                            the norm used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (July 2016)
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
        

    
    bin_loader = strcat('Bin_Delimiters_Altitude_',word_type,'_',num2str(n_bins),'bins');
    eval(bin_loader);
    
    
    delimiters = eval(strcat('Bins.Altitude.',word_type,'.Bins',num2str(n_bins),'.',delimiters_type));
    
    if( ~isempty(iWord) ) 
        Altitude_Angle  = a_good_histogram_function( iWord.Al , delimiters , hist_type );
    else
        Altitude_Angle  = a_good_histogram_function( [] , delimiters , hist_type );
    end
    
    
end