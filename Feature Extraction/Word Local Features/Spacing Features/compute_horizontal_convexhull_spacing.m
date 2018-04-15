function [ space_size_cm , space_x_start , space_y_start , positive_spacing ] = compute_horizontal_convexhull_spacing( Word )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );
    
    Word = resample_word( Word );
       
    [ ~ , ~ , pendown_segments_sort  ] = segment_penups_pendowns_sorted_by_x_coordinate( Word );
    
    space_size_cm = [];
    space_x_start = [];
    space_y_start = [];
    
    y_steps_vals = [ min( Word.Y ):0.01:max( Word.Y ) ];
    n_vert_steps = length(y_steps_vals);
    
    prev_X = zeros(size(y_steps_vals)) - Inf;
    next_X = zeros(size(y_steps_vals));
    
    for k=1:length(pendown_segments_sort)-1
       perv_segment = pendown_segments_sort( k );
       next_segment = combine_multiple_word_structs_under_same_timestamp( pendown_segments_sort( k+1:end ) , false ); 
          

       %get the rightmost points of prev_segment 
       for j=1:n_vert_steps
           indexes   = find( abs(perv_segment.Y - y_steps_vals(j) ) < 0.01 );
           if( ~isempty(indexes) )
               rightmost = max( perv_segment.X(indexes) );
               max_indexes     = indexes( perv_segment.X(indexes) == rightmost );
               rightmost_index = max_indexes(1);
               prev_X(j) = max( perv_segment.X(rightmost_index) , prev_X(j) );
           else
               prev_X(j) = max( -Inf , prev_X(j)) ;
           end
       end   
       

        %get the rightmost points of prev_segment 
        for j=1:n_vert_steps
            indexes   = find( abs(next_segment.Y - y_steps_vals(j) ) < 0.01 );
            if( ~isempty(indexes) )
                lefttmost = min( next_segment.X(indexes) );
                min_indexes    = indexes( next_segment.X(indexes) == lefttmost );
                leftmost_index = min_indexes(1);
                next_X(j) = next_segment.X(leftmost_index);
            else
                next_X(j) = Inf;
            end
        end
       
        delta_x = (next_X - prev_X);
        min_delta_x = min(delta_x);
        min_index   = find( delta_x == min_delta_x );
       
        if( ~isnan( min_delta_x ) && ~isinf( min_delta_x ) )
            space_size_cm = [ space_size_cm; min_delta_x ];
            space_x_start = [ space_x_start; prev_X(min_index(1)) ];
            space_y_start = [ space_y_start; y_steps_vals(min_index(1)) ];
        end
    end
    
    positive_spacing = space_size_cm(space_size_cm > 0);
    
end