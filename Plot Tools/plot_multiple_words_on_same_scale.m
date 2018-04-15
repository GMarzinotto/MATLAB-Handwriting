function [ ] = plot_multiple_words_on_same_scale( Word_Samples_List , plot_func )

    if( nargin < 2 )
        Plot_Style = PlotStyle( false , true );
        plot_func = @(Word) plot_in_black_and_white( Word , Plot_Style );
    end

    n_words = length(Word_Samples_List);
    
    
    %Loop to plot each figure
    for k=1:n_words
        Word_Samples_List(k) = center_word(Word_Samples_List(k));
        figure();
        plot_func( Word_Samples_List(k) )
        h(k) = gca;
    end

    
    % Store the axis limits for each figure
    X = []; Y = [];
    for k=1:n_words
        X = [ X  h(k).XLim ];
        Y = [ Y  h(k).YLim ];
    end    
        
    %Compute the minimum and the maximum for each axis
    xmax = max(X);    xmin = min(X);
    ymax = max(Y);    ymin = min(Y);
    
    %Link Axes from all the plots    
    linkaxes( h , 'xy' )
    axis([ xmin , xmax , ymin , ymax ])
    
    
end