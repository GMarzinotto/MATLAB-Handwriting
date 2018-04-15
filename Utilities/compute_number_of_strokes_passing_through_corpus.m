function [ stroke_counter , crossing_points ] = compute_number_of_strokes_passing_through_corpus( Word , word_type , meadian_line_coefs )
%% compute_number_of_strokes_passing_through_corpus
%  Computes the number of strokes that pass through the corpus of the word
%  at the median line height. 
%
% [ _stroke_counter_ ] = _*compute_number_of_strokes_passing_through_corpus*_ ( _Word_ , _word_type_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
% * *meadian_line_coefs* : Median Line Coefficients, they are computed if
%                          they were not provided in the input
%
%%% Outputs
% 
% * *stroke_counter*  : A Word Struct as defined in this framework 
%                    adding a boolean image. See wordStruct documentation.
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
        meadian_line_coefs = compute_medianline_estimate( Word , 1 , true );
    end

    Word = convert_word_to_a_new_tracking_type( Word , word_type );
    Word = resample_word( Word );
    
    
    stroke_counter = 0;
    crossing_points = [];
    for k = 1:Word.NumSamples-1
        
        if( ~ any( Word.LostOfTrackPoints == k ) )
            kstart_p.X = Word.X(k);    kstart_p.Y = Word.Y(k);
            kend_p.X = Word.X(k+1);    kend_p.Y = Word.Y(k+1);
            
                [ bool_cross , cross_point ] = check_line_cross_given_2_points_and_a_polynomial( meadian_line_coefs , kstart_p , kend_p );
            
            if( bool_cross )
                stroke_counter = stroke_counter + 1;
                crossing_points = [crossing_points; cross_point];
            end
        end
    end
    
    
end