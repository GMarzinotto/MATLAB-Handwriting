function [] = plot_points_crossing_the_median_line( Word )



    plot_in_black_and_white(Word,PlotStyle(false,true));
    hold on
    
    [ stroke_counter , crossing_poins ] = compute_number_of_strokes_passing_through_corpus(Word,'ON_TABLET');
    
    if(~isempty(crossing_poins))
        scatter([crossing_poins.X],[crossing_poins.Y],20,'b','filled');
    end
   
    
end