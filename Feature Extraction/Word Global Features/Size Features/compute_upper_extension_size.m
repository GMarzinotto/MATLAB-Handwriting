function [ avg_upper_extension_size , upper_extension_size ] = compute_upper_extension_size( Word , Canonical_Lines )
%% compute_upper_extension_size
%  Computes the upper extension size of the given Word. 
%  Upper extension size is computed as the espace between the upperline 
%  and the maximum of the word. These lines are determined using
%  a local maxima and local minima method
%
% [ _upper_extension_size_ ] = _*compute_upper_extension_size*_ ( _Word_ , _line_order_ , _rm_outliers_ )
%
%%% Inputs
% 
% * *Word*    : A Word Struct as defined in this framework 
%               see wordStruct documentation. 
%
% * *Canonical_Lines* : A struct containing the canonical lines that will
%                       be used as bin delimiters, if it is not provided 
%                       It computes the canonical lines using the segment
%
%%% Outputs
% 
% * *avg_upper_extension_size* : average upper extension size in cm
%
% * *upper_extension_size* : upper extension size of the word in centimeters
%                     
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%

    if( nargin < 2)
        [ ~ , ~ , ~ , ~ , ~ , Canonical_Lines ] = compute_canonical_lines_height_estimates_with_local_min_max( Word , 0 , true );
    end
    
    x_vals = [ min(Word.X(Word.P>0)):0.1:max(Word.X(Word.P>0)) ];
            
    upper_line_height  = polyval(Canonical_Lines.UpperLine , x_vals);
    
    upper_extension_size = Canonical_Lines.Maximum - upper_line_height;
    
    avg_upper_extension_size = mean(upper_extension_size);

end