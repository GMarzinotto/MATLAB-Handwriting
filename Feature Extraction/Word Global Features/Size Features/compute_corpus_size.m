function [ avg_corpus_size , corpus_size_vals ] = compute_corpus_size( Word , Canonical_Lines )
%% compute_corpus_size
%  Computes the corpus size of the given Word. 
%  Corpus size is computed as the espace between the upperline 
%  and the baseline of the word. These lines are determined using
%  a local maxima and local minima method
%
% [ _avg_corpus_size_ ] = _*compute_corpus_size*_ ( _Word_ , _Canonical_Lines_ )
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
% * *avg_corpus_size* : corpus size of the word in centimeters
%                     
% * *corpus_size_vals* : sampled values of corpus size along the X axis
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
            
    
    upper_line_height = polyval(Canonical_Lines.UpperLine, x_vals);
    base_line_height  = polyval(Canonical_Lines.BaseLine , x_vals);
    
                    
    corpus_size_vals = upper_line_height - base_line_height;
    avg_corpus_size  = mean(corpus_size_vals);

end