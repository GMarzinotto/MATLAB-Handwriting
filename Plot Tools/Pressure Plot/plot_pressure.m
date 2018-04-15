function [ ] = plot_pressure(Word,plotStyle)
%% plot_pressure
%  Plots a word struct using a color scale that represents pressure
%
% [  ] = _*plot_pressure*_ ( _Word_ , _plotStyle_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *plotStyle*  : A PlotStyle object as defined in this framework 
%                  see PlotStyle documentation. 
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (April 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin==1)
        plotStyle = PlotStyle();
    end


    
    %Maximum value of Speed in the parameters
    %Larger values will be saturated to PMax
    PMax = 1; % no units yet

    %We copy the Pressure value to apply saturation
    %At this point saturation is not needed for the Pressure
    %But in the future it might/will be
    ModP = (Word.P(1:end-1) + Word.P(2:end))/2.0;

    %We saturate to a value that allows us to appreciate the
    %different movement pressure on pen down
    ModP(ModP>PMax) = PMax;
    
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, ModP, PMax);

    h = colorbar('FontSize',12);
    h.Label.String = strcat('Normalized Pressure');
    axis equal
    
end
          
