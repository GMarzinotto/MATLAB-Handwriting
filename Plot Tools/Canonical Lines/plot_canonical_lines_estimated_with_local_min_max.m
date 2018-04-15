function [] = plot_canonical_lines_estimated_with_local_min_max( Word , line_order, rm_outliers , plotStyle )
%% plot_canonical_lines_estimated_with_local_min_max
%  Plots a word struct and display its canonical lines estimates.
%  In order to use this function properly, the Word object must contain
%  a single line text (or word), multiline texts requiere previous
%  segmentation in line.
%  This function may not work properly when text samples are to short
%  to compute a canonical line estimates.
%  
%
% [  ] = _*plot_canonical_lines_estimated_with_local_min_max*_ ( _Word_ , _line_order_ , _rm_outliers_ , _plotStyle_ )
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

    if( nargin < 2 )
        line_order = 1;
    end

    if( nargin < 3 )
       rm_outliers = true; 
    end

    %If no style is provided use default
    if(nargin<4)
        plotStyle = PlotStyle();
    end
    
    [  ~ , ~ , ~ , ~ , ~ , Canonical_Lines ] = ...
        compute_canonical_lines_height_estimates_with_local_min_max( Word , line_order , rm_outliers );
  
    
    min_x = min(Word.X);
    max_x = max(Word.X);
    Xrange = min_x:0.1:max_x;
    
    %baseline vectors to plot
    Y_vals_baseline    = polyval( Canonical_Lines.BaseLine  , Xrange );
    
    %upperline vectors to plot
    Y_vals_upperline   = polyval( Canonical_Lines.UpperLine , Xrange ); 
       
    %medianline vectors to plot
    Y_vals_meadianline = polyval( Canonical_Lines.MedianLine  , Xrange ); 

    
    plot_in_black_and_white(Word, plotStyle, 'k' )
    hold on
    plot( Xrange , Y_vals_meadianline  , 'r' );
    plot( Xrange , Y_vals_baseline     , 'g' );
    plot( Xrange , Y_vals_upperline    , 'b' );
    plot( [min_x max_x] , [ Canonical_Lines.Minimum Canonical_Lines.Minimum ] , 'y' );
    plot( [min_x max_x] , [ Canonical_Lines.Maximum Canonical_Lines.Maximum ] , 'm' );
    
end