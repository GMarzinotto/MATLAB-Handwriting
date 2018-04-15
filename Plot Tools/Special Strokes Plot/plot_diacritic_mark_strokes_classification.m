function [] = plot_diacritic_mark_strokes_classification( Word , plotStyle )
%% plot_diacritic_mark_strokes_classification
%  Plots a word struct using a color code black for normal text 
%  and other colors depending of the diacritic or punctuation mark
%
% [  ] = _*plot_diacritic_mark_strokes_classification*_ ( _Word_ , _plotStyle_ )
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
    labels  = classify_diacritic_marks( Word );

    
    plot_in_black_and_white( Word, plotStyle );
    hold on
    
    class_names = {'normal','Apostrophe','Grave Accent','Acute Accent',...
                   'Circumflex','Character Dot','T Bar','Cedilla'};
         
    Colors = distinguishable_colors(length(class_names));
    p = scatter(mean(Word.X),mean(Word.Y),0.01,'k','filled');
     
    for i=2:length(class_names)
        itype_segments = all_segments( ismember(labels,class_names{i}));
        ihandle = scatter(mean(Word.X),mean(Word.Y),0.01,Colors(i,:),'filled');
        p = [p ihandle];
        for k=1:length(itype_segments)
            plot_in_black_and_white( itype_segments(k) , plotStyle , Colors(i,:) );
        end
    end
    
    legend(p,class_names)
    axis equal

end