function [ histogram_vals ] = compute_word_point_dist_hist_wrt_canonical_lines( Segment , word_type , Canonical_Lines )
%% compute_word_point_dist_hist_wrt_canonical_lines
%  Computes the percentages of points of the Segment object belonging
%  to each interval of height, using the canonical lines as bin separators
%  if the canonical lines are not specified, the function computes them
%  using the Segment object as a reference.
%                       
%
% [ _histogram_vals_ ] = _*compute_word_point_dist_hist_wrt_canonical_lines*_ ( _Segment_ , _Canonical_Lines_ )
%
%%% Inputs
% 
% * *Segment*      : A Word Struct as defined in this framework 
%                     see wordStruct documentation.  
%
% * *word_type*     : A type to convert the Word Struct into. There are 3 
%                     types ON_TABLET , ON_AIR, ON_TABLET_ON_AIR 
%
% * *Canonical_Lines* : A struct containing the canonical lines that will
%                       be used as bin delimiters, if it is not provided 
%                       It computes the canonical lines using the segment
%                      
%
%%% Outputs
%
% * *histogram_vals*  : A struct containing the percentages of points 
%                       of the Segment object belonging to each interval of
%                       height, using the canonical lines as bin separators
%
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%


    if(nargin < 3)
        [ ~ , ~ , ~ , ~ , ~ , Canonical_Lines ] = compute_canonical_lines_height_estimates_with_local_min_max( Segment , 0 , true );
    end

    Segment = convert_word_to_a_new_tracking_type ( Segment , word_type );
    if(~isempty(Segment))
        BaseLine_Ys   = polyval( Canonical_Lines.BaseLine   , Segment.X );
        UpperLine_Ys  = polyval( Canonical_Lines.UpperLine  , Segment.X );
        MedianLine_Ys = polyval( Canonical_Lines.MedianLine , Segment.X );


        low_vals     = sum( Segment.Y < BaseLine_Ys );
        midlow_vals  = sum( Segment.Y >= BaseLine_Ys   & Segment.Y < MedianLine_Ys );
        midhigh_vals = sum( Segment.Y >= MedianLine_Ys & Segment.Y < UpperLine_Ys  );
        high_vals    = sum( Segment.Y >= UpperLine_Ys );


        histogram_vals.low      = low_vals/Segment.NumSamples;
        histogram_vals.midlow   = midlow_vals/Segment.NumSamples;
        histogram_vals.mid      = ( midlow_vals + midhigh_vals )/Segment.NumSamples; 
        histogram_vals.midhigh  = midhigh_vals/Segment.NumSamples;
        histogram_vals.high     = high_vals/Segment.NumSamples;
    
    else
        
        histogram_vals.low      = NaN;
        histogram_vals.midlow   = NaN;
        histogram_vals.mid      = NaN;
        histogram_vals.midhigh  = NaN;
        histogram_vals.high     = NaN;
        
    end

end