function [] = plot_convexhull_spaces( Word )


    plot_in_black_and_white(Word,PlotStyle(false,true));
    hold on
    
    [ space_size_cm , space_x_start , space_y_start ] = compute_horizontal_convexhull_spacing( Word );

    
    for k=1:length(space_size_cm)
        plot( [space_x_start(k) (space_x_start(k) + space_size_cm(k)) ] , [space_y_start(k) space_y_start(k)] )
    end
    
end