function [ ] = plot_jerk_module(Word,plotStyle,MaxVal)
%% plot_jerk_module
%  Plots a word struct using a color scale that represents jerk
%
% [  ] = _*plot_jerk_module*_ ( _Word_ , _plotStyle_ , _MaxVal_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *plotStyle*  : A PlotStyle object as defined in this framework 
%                  see PlotStyle documentation. 
%
% * *MaxVal*    : Maximum Value to saturate Colobar  
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (April 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin<2)
        plotStyle = PlotStyle();
    end
    
    %Maximum value of Jerk in the parameters
    %Larger values will be saturated to JMax
    if(nargin<3)
        JMax = 50000; % in cm/s^3
    else
        JMax = MaxVal;
    end

	[ ModJ ]   = compute_all_jerks(Word);

    %Speed on Air is much faster than on ground... Therefore
    %We saturate to a value that allows us to appreciate the
    %different movement speeds on pen down
    ModJ(ModJ>JMax) = JMax;
    ModJ = [ModJ(1); ModJ; ModJ(end)];
    
    %Plot Everything
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, ModJ, JMax);
    
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('Jerk Module (cm/s^3)');
    axis equal
    
end