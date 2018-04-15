function [ ] = plot_speed_x(Word,plotStyle,MaxVal)
%% plot_speed_x
%  Plots a word struct using a color scale that represents X speed
%
% [  ] = _*plot_speed_x*_ ( _Word_ , _plotStyle_ )
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
    
    %Maximum value of Speed in the parameters
    %Larger values will be saturated to VMax
    if(nargin<3)
        VMax = 20; % in cm/s
    else
        VMax = MaxVal;
    end

	[ ~ ,vx, ~ ]   = compute_all_speeds(Word);
    ModV = abs(vx);

    %Speed on Air is much faster than on ground... Therefore
    %We saturate to a value that allows us to appreciate the
    %different movement speeds on pen down
    ModV(ModV>VMax) = VMax;
    
    %Plot Everything
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, ModV, VMax);
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('X Speed (cm/s)');
    axis equal
    
end