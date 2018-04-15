function [ bool_cross , cross_point ] = check_line_cross_given_2_points_and_a_polynomial( polynomial , segment_start, segment_end )
%% check_line_cross_given_2_points_and_a_polynomial
%  check if a segment crosses a Polynomial on the XY plane,  
%
%
% [ _bool_cross_ , _cross_point_ ] = _*check_line_cross_given_2_points_and_a_polynomial*_ ( _polynomial_ , _segment_start_ , _segment_end_ )
%
%%% Inputs
% 
% * *polynomial* :  Polynomial Coefficients to verify the intersection. 
%
% * *segment_start* :  Coordiantes X Y of the start point of Segment 1. 
%
% * *segment_end*   :  Coordiantes X Y of the end point of Segment 1. 

%
%%% Outputs
% 
% * *bool_cross*  : True if segments cross, false otherwise
%
% * *cross_point* : Coordiantes X Y of the crossing point of both segments. 
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    segment2_start = segment_start;
    segment2_start.Y = polyval( polynomial , segment2_start.X );
    
    segment2_end = segment_end;
    segment2_end.Y = polyval( polynomial , segment2_end.X );
   
    [ bool_cross , cross_point ] = check_line_cross_given_4_points( segment_start, segment_end , segment2_start , segment2_end );

    
end