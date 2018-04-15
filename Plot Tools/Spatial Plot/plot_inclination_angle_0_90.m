function [ ] = plot_inclination_angle_0_90(Word,plotStyle)
%% plot_inclination_angle_0_90
%  Plots a word struct using a color scale that represents the inclination
%  angle on an interval [0 90]. This interval of angles measured the 
%  veticality of the text and makes the inclination values to ignore the
%  direction in which the stroke is performed as well as whether the words
%  are inclinated to the left of to the right. 
%
% [  ] = _*plot_inclination_angle_0_90*_ ( _Word_ , _plotStyle_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *plotStyle*  : A PlotStyle object as defined in this framework 
%                  see PlotStyle documentation. 
% 
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin<2)
        plotStyle = PlotStyle();
    end
    
    %Maximum value of inclination absolute angle
    Max_Val = 90; % in degrees
  

	[ ~ , ~ , angle_0_90 ]   = compute_all_inclinations(Word);

    
    %We saturate to a values to the given range
    angle_0_90(angle_0_90>Max_Val) = Max_Val;
    
 
    %Plot Everything
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, angle_0_90, Max_Val);
    
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('Inclination Angle [0º - 90º] (degrees)');
    axis equal
    
end