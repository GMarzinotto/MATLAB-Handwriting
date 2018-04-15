function [ avg_lower_extension_size , lower_extension_size ] = compute_lower_extension_size( Word , Canonical_Lines )
%% compute_lower_extension_size
%  Computes the lower extension size of the given Word. 
%  Lower extension size is computed as the espace between the baseline 
%  and the minimum of the word. These lines are determined using
%  a local maxima and local minima method
%
% [ _lower_extension_size_ ] = _*compute_lower_extension_size*_ ( _Word_ , _Canonical_Lines_ )
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
% * *avg_lower_extension_size* : lower extension size average
%
% * *lower_extension_size* : lower extension size of the word in centimeters
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
            
    base_line_height  = polyval(Canonical_Lines.BaseLine , x_vals);
    
    lower_extension_size = base_line_height - Canonical_Lines.Minimum;
    
    avg_lower_extension_size = mean(lower_extension_size);

end