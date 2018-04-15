function [ ] = plot_penup_pendown_segments(Word,plotStyle)
%% plot_penup_pendown_segments
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
%  Author :     G. Marzinotto (April 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin==1)
        plotStyle = PlotStyle();
    end

    %Get a List of the Relevant Points Separators
    [ ~ , ~ , ~ , separators ] = segment_by_penups_pendowns(Word);

    generic_word_plot_using_segmentation(Word,plotStyle,separators);
    
    axis equal
    
end