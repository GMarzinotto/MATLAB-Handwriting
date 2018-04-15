function [] = plot_medianline_estimate( Word , line_order , rm_outliers )
%% plot_medianline_estimate
%  Plots a word struct and display its medianline estimate.
%  In order to use this function properly, the Word object must contain
%  a single line text (or word), multiline texts requiere previous
%  segmentation in line.
%  This function may not work properly when text samples are to short
%  to compute a canonical line estimates.
%  
%
% [  ] = _*plot_medianline_estimate*_ ( _Word_ , _line_order_ , _rm_outliers_ , _plotStyle_ )
%
%%% Inputs
% 
% * *Word*          : A Word Struct as defined in this framework 
%                     see wordStruct documentation. 
%
% * *line_order*    : Order of the polinomial approximations for the
%                     canonical lines 0, 1 ,2 ... larger values cause
%                     overfitting
%
% * *rm_outliers*   : boolean value, set to true makes a more robust fit as
%                     it removes local minima and maxima classed as outliers
%
% * *plotStyle*     : A PlotStyle object as defined in this framework 
%                     see PlotStyle documentation. 
%
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%

    if(nargin < 2)
        line_order = 1;
    end
    if(nargin < 3)
        rm_outliers = true;
    end

   [ medianline_coefs  ] = compute_medianline_estimate( Word , line_order , rm_outliers );
   
   Xrange = [ min(Word.X):0.1:max(Word.X) ];

   
   plot_in_black_and_white(Word); 
   hold on;
   plot( Xrange , polyval(medianline_coefs,Xrange) );

end