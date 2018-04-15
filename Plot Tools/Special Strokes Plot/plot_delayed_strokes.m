function [] = plot_delayed_strokes( Word , plotStyle )
%% plot_delayed_strokes
%  Plots a word struct using a color code black for normal text red 
%  for delayed strokes
%
% [  ] = _*plot_delayed_strokes*_ ( _Word_ , _plotStyle_ )
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
    all_segments  = segment_by_penups_pendowns(Word);
    labels  = detect_delayed_strokes( Word );
    delayed_segments = all_segments(labels);
    
    plot_in_black_and_white( Word, plotStyle );
    hold on
    
    for k=1:length(delayed_segments)
        plot_in_black_and_white( delayed_segments(k) , plotStyle , 'r' );
    end
    

    
    
    axis equal


end