function [ ] = plot_strokes_vy_criterion(Word,plotStyle)
%% plot_strokes_vy_criterion
%  Plots a word struct using a color code for each penup pendown segments
%
% [  ] = _*plot_penup_pendown_segments*_ ( _Word_ , _plotStyle_ )
%
%%% Inputs
% 
% * *Word*       : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *plotStyle*  : A PlotStyle object as defined in this framework 
%                  see PlotStyle documentation. 
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin==1)
        plotStyle = PlotStyle();
    end

    %Boolean to decide if on air trajectory will be displayed
    plotOnAir    = plotStyle.plotOnAir;
    plotOnTablet = plotStyle.plotOnTablet;
    
    %LineWidths
    lineWidthPenDown = plotStyle.lineWidthPenDown;
    lineWidthPenUp   = plotStyle.lineWidthPenUp;

    %Maximum value IDX => Number of colors
    IDMax = 10; 
    colors = distinguishable_colors(IDMax);     
    
    %Create a List of the Relevant Points
    [ ~ , ~ , ~ , separators ] = segment_by_strokes_vy_criterion(Word);

    generic_word_plot_using_segmentation(Word,plotStyle,separators);
 
    
    axis equal
    
end