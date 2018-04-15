function [ ] = generic_word_plot_in_continuous_color_scale(Word, plotStyle, Magnitudes, Magnitude_MAX)


    %Load booleans to decide if on air trajectory will be displayed
    plotOnAir    = plotStyle.plotOnAir;
    plotOnTablet = plotStyle.plotOnTablet;
    
    %Load Line Widths for penup and pendown
    lineWidthPenDown = plotStyle.lineWidthPenDown;
    lineWidthPenUp   = plotStyle.lineWidthPenUp;

    %Load JetColor for the magnitude scale
    jetColor = plotStyle.jetColor;
    

    %Plot a first point with the maximum value
    x = [ min(Word.X)  min(Word.X) + 10^-8];
    y = [-min(Word.Y) -min(Word.Y) - 10^-8];
    z = zeros(size(x));
    col = Magnitude_MAX*ones(size(x)); 
    surface([x;x],[y;y],[z;z],[col;col],'facecol','no','edgecol','interp','linew',1);
    hold on;
    
    %Create a List of the Relevant Points
    singularPoints = find_singular_points(Word);
        
    for j=1:length(singularPoints)-1
        
        if(singularPoints(j)+1 <  singularPoints(j+1))
            %Plot the Pen-Up parts of the sequence, If there is no  
            %tracking on air it will not plot anything
            %It can also be disabled using input parameters
            if ((plotOnAir) && ((Word.P(singularPoints(j))==0 && Word.P(singularPoints(j)+1)==0 && ...
                ( (~isempty( Word.LostOfTrackPoints ) && ~any(Word.LostOfTrackPoints == singularPoints(j) )) ...
                || isempty( Word.LostOfTrackPoints )    )) || ...
                (Word.P(singularPoints(j))>0 && Word.P(singularPoints(j)+1)==0)))

                z = zeros(1,singularPoints(j+1) - singularPoints(j));
                col = Magnitudes(singularPoints(j):singularPoints(j+1)-1)';
                x = Word.X(singularPoints(j):singularPoints(j+1)-1)';
                y = Word.Y(singularPoints(j):singularPoints(j+1)-1)';
                surface([x;x],[y;y],[z;z],[col;col],...
                        'facecol','no','edgecol','interp','linew',lineWidthPenUp,'LineStyle','-.');  
            end

            %Plot the Pen-Down parts of the sequence
            %It can also be disabled using input parameters
            if ((plotOnTablet) && ((Word.P(singularPoints(j))>0 && Word.P(singularPoints(j)+1)>0 && ...
                ( (~isempty( Word.LostOfTrackPoints ) && ~any(Word.LostOfTrackPoints == singularPoints(j) )) ...
                || isempty( Word.LostOfTrackPoints )    )) || ...
                (Word.P(singularPoints(j))==0 && Word.P(singularPoints(j)+1)>0)))

                z = zeros(1,singularPoints(j+1) - singularPoints(j));
                col = Magnitudes(singularPoints(j):singularPoints(j+1)-1)';
                x = Word.X(singularPoints(j):singularPoints(j+1)-1)';
                y = Word.Y(singularPoints(j):singularPoints(j+1)-1)';
                surface([x;x],[y;y],[z;z],[col;col],...
                        'facecol','no','edgecol','interp','linew',lineWidthPenDown);  
            end
            hold on
        end
    end
 

    colormap(jet(jetColor));

end