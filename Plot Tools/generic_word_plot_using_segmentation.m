function [ ] = generic_word_plot_using_segmentation(Word,plotStyle,separators)
%% generic_word_plot_using_segmentation
%  Plots a word struct using a color code for each penup pendown segments
%
% [  ] = _*generic_word_plot_using_segmentation*_ ( _Word_ , _plotStyle_ , _separators_ )
%
%%% Inputs
% 
% * *Word*       : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *plotStyle*  : A PlotStyle object as defined in this framework 
%                  see PlotStyle documentation. 
%
% * *separators* : markers to distinguish a segment
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    %Boolean to decide if on air trajectory will be displayed
    plotOnAir    = plotStyle.plotOnAir;
    plotOnTablet = plotStyle.plotOnTablet;
    
    %LineWidths
    lineWidthPenDown = plotStyle.lineWidthPenDown;
    lineWidthPenUp   = plotStyle.lineWidthPenUp;
    
    %Display text indexes 
    display_tags     = plotStyle.display_tags;

    %Maximum value IDX => Number of colors
    IDMax  = plotStyle.discreteColors; 
    colors = distinguishable_colors(IDMax);     
    plots_count = 1;
    %At each iteration of this loop we plot the information between
    %two relevan points that usually corresponds to a continuous Pen-Down
    %trajectory or also to a continuos Pen-Up Trajectory
    for k=1:size(separators,1)
        
        if(separators(k,1)+1 <  separators(k,2))
            
            if(display_tags)
                scatter( Word.X([separators(k,1) separators(k,2)]) , Word.Y([separators(k,1) separators(k,2)]) , 10 , 'k' )
                text( mean(Word.X([separators(k,1) separators(k,2)])) , mean(Word.Y([separators(k,1) separators(k,2)])), num2str(k) )
                hold on
            end
            
            %Plot the Pen-Up parts of the sequence, If there is no  
            %tracking on air it will not plot anything
            %It can also be disabled using input parameters
            if ((plotOnAir) && ((Word.P(separators(k,1))==0 && Word.P(separators(k,1)+1)==0 && ...
                    (~any(separators(k,1) == Word.LostOfTrackPoints))) || ...
                    ...%(Word.T(separators(j,1)+1) - Word.T(separators(j,1)) < 3*Word.SamplePeriod)) || ...
                    (Word.P(separators(k,1))>0 && Word.P(separators(k,1)+1)==0)))

                col_idx = mod(plots_count,IDMax) + 1;
                x = Word.X(separators(k,1):separators(k,2))';
                y = Word.Y(separators(k,1):separators(k,2))';
                plot(x,y,'Color',colors(col_idx,:),'LineWidth',lineWidthPenUp,'LineStyle','-.');  
                plots_count = plots_count + 1;
            end

            %Plot the Pen-Down parts of the sequence
            %It can also be disabled using input parameters
            if ((plotOnTablet) && ((Word.P(separators(k,1))>0 && Word.P(separators(k,1)+1)>0 && ...
                    (~any(separators(k,1) == Word.LostOfTrackPoints))) || ...
                    ... %(Word.T(separators(j,1)+1) - Word.T(separators(j,1)) < 3*Word.SamplePeriod)) || ...
                    (Word.P(separators(k,1))==0 && Word.P(separators(k,1)+1)>0)))

                col_idx = mod(plots_count,IDMax) + 1;
                x = Word.X(separators(k,1):separators(k,2))';
                y = Word.Y(separators(k,1):separators(k,2))';
                plot(x,y,'Color',colors(col_idx,:),'LineWidth',lineWidthPenDown);  
                plots_count = plots_count + 1;
            end
            hold on
        end
    end
 
    
    axis equal
    
end