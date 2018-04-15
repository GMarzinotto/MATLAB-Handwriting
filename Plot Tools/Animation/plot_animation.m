function [] = plot_animation( Word , plotStyle , SaveFilePath , IDX_FIG, color )


    if(nargin<5)
        color = 'k';
    end
    if(nargin<4)
        IDX_FIG = 1;
    end
    if(nargin<3)
        SaveFilePath = tempname;
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

    
    figure(IDX_FIG),
    LIMITSX = [min(Word.X)-1 , max(Word.X)+1];
    LIMITSY = [min(Word.Y)-1 , max(Word.Y)+1];
    
    xlim( LIMITSX );
    ylim( LIMITSY );
            
    
    drawnow
    frame = getframe(IDX_FIG);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,SaveFilePath,'gif','DelayTime',0, 'Loopcount',inf);
    
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
            t = Word.T(singularPoints(j):singularPoints(j+1)-1)';
            plot_sub_gif(IDX_FIG,x,y,t,color,lineWidthPenUp,'-.')
            %plot(x,y,'Color',color,'LineWidth',lineWidthPenUp,'LineStyle','-.');  
        end
        
        %Plot the Pen-Down parts of the sequence
        %It can also be disabled using input parameters
        if ((plotOnTablet) && ((Word.P(singularPoints(j))>0 && Word.P(singularPoints(j)+1)>0 && ...
                ( (~isempty( Word.LostOfTrackPoints ) && ~any(Word.LostOfTrackPoints == singularPoints(j) )) ...
                || isempty( Word.LostOfTrackPoints )    )) || ...
                (Word.P(singularPoints(j))==0 && Word.P(singularPoints(j)+1)>0)))
            
            x = Word.X(singularPoints(j):singularPoints(j+1)-1)';
            y = Word.Y(singularPoints(j):singularPoints(j+1)-1)';
            t = Word.T(singularPoints(j):singularPoints(j+1)-1)';
            plot_sub_gif(IDX_FIG,x,y,t,color,lineWidthPenDown,'-')
            %plot(x,y,'Color',color,'LineWidth',lineWidthPenDown);  
        end
        hold on
    end
 
    
    
    function [] = plot_sub_gif(IDX_FIG,x,y,t,color,lineWidth,lineStyle)
        
        [~ , nb_samples] = size(x);
        
        oldPoint = [t(1),x(1),y(1)];
        for k = 2:nb_samples
            newPoint = [t(k),x(k),y(k)];
            line_t = [oldPoint(1),newPoint(1)];
            line_x = [oldPoint(2),newPoint(2)];
            line_y = [oldPoint(3),newPoint(3)];
            plot(line_x,line_y,'Color',color,'LineWidth',lineWidth,'LineStyle',lineStyle);
            
            xlim( LIMITSX );
            ylim( LIMITSY );

            drawnow
            frame = getframe(IDX_FIG);
            im = frame2im(frame);
            [imind,cm] = rgb2ind(im,256);
            imwrite(imind,cm,SaveFilePath,'gif','DelayTime',(line_t(2)-line_t(1))/1000,'WriteMode','append');
            oldPoint = newPoint;
            hold on
        end
    end
        
    

   
    
end
