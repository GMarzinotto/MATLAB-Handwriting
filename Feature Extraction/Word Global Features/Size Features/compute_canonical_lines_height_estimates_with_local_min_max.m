function [  median_height , base_height , upper_height , minimum_height , maximum_height , Canonical_Lines ] = compute_canonical_lines_height_estimates_with_local_min_max( Word , line_order , rm_outliers )
%% compute_canonical_lines_height_estimates_with_local_min_max
%  Computes the height of each canonical line. 
%  In order to use this function properly, the Word object must contain
%  a single line text (or word), multiline texts requiere previous
%  segmentation in line.
%  This function may not work properly when text samples are to short
%  to compute a canonical line estimates.
%  
%
% [ _median_height_ , _base_height_ , _upper_height_ , _minimum_height_ , _maximum_height_ , _Canonical_Lines_ ] = _*compute_canonical_lines_height_estimates_with_local_min_max*_ ( _Word_ , _line_order_ , _rm_outliers_ )
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
%
%%% Outputs
%
% * *median_height*   : Medianline height
%
% * *base_height*     : Baseline height
%
% * *upper_height*    : Upperline height
%
% * *minimum_height*  : Minimum height
%
% * *maximum_height*  : Maximum height
%
% * *Canonical_Lines* : Line object containing all the line coefficients
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%


    [ baseline_coefs  ] = compute_baseline_estimate ( Word , line_order , rm_outliers );
    [ upperline_coefs ] = compute_upperline_estimate( Word , line_order , line_order );
    
    %Ensure both lines are the same order
    if( length(baseline_coefs) ~= length(upperline_coefs) )
        if( length(baseline_coefs) > length(upperline_coefs) )
            [ baseline_coefs  ] = compute_baseline_estimate ( Word , length(upperline_coefs)-1 , rm_outliers );
        else
            [ upperline_coefs ] = compute_upperline_estimate( Word , length(baseline_coefs)-1 , line_order );
        end
    end
    
    medianline_coefs = (baseline_coefs + upperline_coefs)/2.0;   
    
    %Store Heighs
    median_height  = medianline_coefs(end);
    base_height    = baseline_coefs(end);
    upper_height   = upperline_coefs(end);
    
    %Minimum Line
    minimum_height = min(Word.Y(Word.P>0));
    
    %Maximum Line
    maximum_height = max(Word.Y(Word.P>0));
    
    Canonical_Lines.MedianLine = medianline_coefs;
    Canonical_Lines.BaseLine   = baseline_coefs;
    Canonical_Lines.UpperLine  = upperline_coefs;
    Canonical_Lines.Minimum    = minimum_height;
    Canonical_Lines.Maximum    = maximum_height;


end