function [ space_sizes , space_position ] = compute_horizontal_medianline_spacing( Word , median_line_coefs )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );

    if(nargin < 2) 
        if(strcmp(Word.ContentType,'LINE'))
            median_line_coefs = compute_medianline_estimate( Word , 1 , true );
        end
        if(strcmp(Word.ContentType,'WORD'))
            median_line_coefs = compute_medianline_estimate( Word , 0 , true );
        end
    end
    
    
    [ ~ , ~ , pendown_segments_sort  ] = segment_penups_pendowns_sorted_by_x_coordinate( Word );

    n_pendown_segments = length(pendown_segments_sort);
    min_crossing_points_x = [];
    max_crossing_points_x = [];
    for k=1:n_pendown_segments
        [ counter , crossing_poins ] = compute_number_of_strokes_passing_through_corpus( pendown_segments_sort(k) , 'ON_TABLET' , median_line_coefs );
        if(counter > 0)
            min_x = min([crossing_poins.X]);
            max_x = max([crossing_poins.X]);
            min_crossing_points_x = [min_crossing_points_x; min_x];
            max_crossing_points_x = [max_crossing_points_x; max_x];
        end
    end
    
    if( length(min_crossing_points_x) > 2 && length(max_crossing_points_x) > 2 )
        space_sizes    =   min_crossing_points_x(2:end) - max_crossing_points_x(1:end-1);
        space_position = ( min_crossing_points_x(2:end) + max_crossing_points_x(1:end-1) )/2.0;
    else 
        space_sizes = [];
        space_position = [];
    end

end