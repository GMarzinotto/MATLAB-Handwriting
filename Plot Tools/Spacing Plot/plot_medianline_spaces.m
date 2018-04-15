function [] = plot_medianline_spaces( Word )


    plot_in_black_and_white(Word,PlotStyle(false,true));
    hold on
    
    [ ~ , crossing_poins ] = compute_number_of_strokes_passing_through_corpus(Word,'ON_TABLET');
    [ ~ , space_position ] = compute_horizontal_medianline_spacing( Word );
    
    if(~isempty(crossing_poins))
        scatter([crossing_poins.X],[crossing_poins.Y],20,'b','filled');
    end
    
    max_y = max(Word.Y(Word.P>0));
    min_y = min(Word.Y(Word.P>0));
    
    for k=1:length(space_position)
        plot( [ space_position(k) space_position(k) ] , [ max_y min_y ] );
    end
   
    
end