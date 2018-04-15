function [Area] = compute_area_of_triangle( pt1 , pt2 , pt3 )
%% compute_area_of_triangle
%  Computes the area of the triangle defined by the vertex pt1 , pt2 , pt3
%
%
% [ _Area_ ] = _*compute_area_of_triangle*_ ( _pt1_ , _pt2_ , _pt3_ )
%
%%% Inputs
% 
% * *pt1*      :  Coordiantes X Y of the 1st vertex of the triangle. 
%
% * *pt2*      :  Coordiantes X Y of the 2nd vertex of the triangle. 
%
% * *pt3*      :  Coordiantes X Y of the 3rd vertex of the triangle. 
%
%%% Outputs
% 
% * *Stroke_TimeDuration*  : A struct containing all the parameters, organized first in
%                            the norm used, and then in the statistic parameter
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    Area = abs((1/2)*((pt1(1)*pt2(2) + pt2(1)*pt3(2) + pt3(1)*pt1(2)) - ((pt1(1)*pt3(2) + pt3(1)*pt2(2) + pt2(1)*pt1(2)))));
    
end