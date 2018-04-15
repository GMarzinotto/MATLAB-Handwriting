function [ ] = plot_in_black_and_white(Word, plotStyle, color )


    if(nargin<3)
        color = 'k';
    end
    %If no style is provided use default
    if(nargin<2)
        plotStyle = PlotStyle();
    end
    


    %Load booleans to decide if on air trajectory will be displayed
    plotOnAir    = plotStyle.plotOnAir;
    plotOnTablet = plotStyle.plotOnTablet;
    
    %Load Line Widths for penup and pendown
    lineWidthPenDown = plotStyle.lineWidthPenDown;
    lineWidthPenUp   = plotStyle.lineWidthPenUp;

    
    %Create a List of the Relevant Points
    singularPoints = find_singular_points(Word);
        
    for j=1:length(singularPoints)-1
        %Plot the Pen-Up parts of the sequence, If there is no  
        %tracking on air it will not plot anything
        %It can also be disabled using input parameters
        if ((plotOnAir) && ((Word.P(singularPoints(j))==0 && Word.P(singularPoints(j)+1)==0 && ...
                ( (~isempty( Word.LostOfTrackPoints ) && ~any(Word.LostOfTrackPoints == singularPoints(j) )) ...
                || isempty( Word.LostOfTrackPoints )    )) || ...
                (Word.P(singularPoints(j))>0 && Word.P(singularPoints(j)+1)==0)))
            
            x = Word.X(singularPoints(j):singularPoints(j+1)-1)';
            y = Word.Y(singularPoints(j):singularPoints(j+1)-1)';
            plot(x,y,'Color',color,'LineWidth',lineWidthPenUp,'LineStyle','-.');  
        end
        
        %Plot the Pen-Down parts of the sequence
        %It can also be disabled using input parameters
        if ((plotOnTablet) && ((Word.P(singularPoints(j))>0 && Word.P(singularPoints(j)+1)>0 && ...
                ( (~isempty( Word.LostOfTrackPoints ) && ~any(Word.LostOfTrackPoints == singularPoints(j) )) ...
                || isempty( Word.LostOfTrackPoints )    )) || ...
                (Word.P(singularPoints(j))==0 && Word.P(singularPoints(j)+1)>0)))
            
            x = Word.X(singularPoints(j):singularPoints(j+1)-1)';
            y = Word.Y(singularPoints(j):singularPoints(j+1)-1)';
            plot(x,y,'Color',color,'LineWidth',lineWidthPenDown);  
        end
        hold on
    end
 

end