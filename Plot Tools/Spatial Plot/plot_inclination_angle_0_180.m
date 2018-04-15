function [ ] = plot_inclination_angle_0_180(Word,plotStyle)
%% plot_inclination_angle_0_180
%  Plots a word struct using a color scale that represents the inclination
%  angle on an interval [0 180]. The negative angles are converted to
%  possitive by taking the complement (+180º) this makes the inclination
%  values to ignore the direction in which the stroke is performed. Except
%  for the 0 and 180 degrees which correspond to the same inclination,
%  however produce two different angles
%
% [  ] = _*plot_inclination_angle_0_180*_ ( _Word_ , _plotStyle_ )
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
    Max_Val = 180; % in degrees
  

	[ ~ , angle_deg_abs ]   = compute_all_inclinations(Word);

    %Speed on Air is much faster than on ground... Therefore
    %We saturate to a value that allows us to appreciate the
    %different movement speeds on pen down
    angle_deg_abs(angle_deg_abs>Max_Val) = Max_Val;
    
 
    %Plot Everything
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, angle_deg_abs, Max_Val);
    
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('Inclination Angle Absolute Value (degrees)');
    axis equal
    
end