function [ Line , stroke_index_in_line , line_index ] = get_text_line_containing_stroke( Word , Stroke )


    

    %Pre Segment in Penups and Pendowns
    [all_segments, ~ , ~ , separators] = segment_by_penups_pendowns(Word);
    
    n_segments = length(all_segments);
    
    searched_stroke_index = -1;
    for k=1:n_segments
        if( are_words_equal( all_segments(k) , Stroke ) )
            searched_stroke_index = k;
            break;
        end
    end
    
    if(searched_stroke_index == -1)
        error('The Stroke you asked to retrieve is not in the Word object provided');
    end
    
    
    
    %Mark the Pendown Segments
    is_pendown = [];
    for k=1:n_segments
        if(strcmp(all_segments(k).Tracking,'ON_TABLET'))
            is_pendown = [is_pendown; k];
        end
    end
    
    line_delimiters = [];
    start_stroke    =  1;
    dist_maxes      = [];

    is_this_line = false;
    break_loop   = false;
    %Loop through the Pendown Segments
    for k = 1:length(is_pendown)-1
        
        if( ~ is_this_line && is_pendown(k) >= searched_stroke_index )
            is_this_line = true;
        end
        
        
        kElem = is_pendown(k);
        next_elem = is_pendown(k+1);
        
        ditance_x = abs(all_segments(kElem).X(end) - all_segments(next_elem).X(1));
        ditance_y = abs(all_segments(kElem).Y(end) - all_segments(next_elem).Y(1));
        
        dist_maxes = [dist_maxes;  max(ditance_x,ditance_y)];
        
        line_index = -1;
        %Find a retour in the X axis or the Y axis is larger than 6cm and mark as a new line
        if( max(ditance_x,ditance_y) > 6 )
            end_stroke = kElem;
            line_delimiters = [line_delimiters; [separators(start_stroke,1)  separators(end_stroke,2)]];
            start_stroke    = next_elem;
            if(is_this_line)
                line_index = length( line_delimiters(:,1) );
                break_loop = true;
            end
        end
        
        if(break_loop)
            break;
        end
        
    end
    

    
    %Add the last line delimiter
    line_delimiters = [line_delimiters; [separators(start_stroke,1)  separators(end,2)]];
    if(~break_loop)
        line_index = length( line_delimiters(:,1) );
    end
    
    Line = segment_using_separators( Word, line_delimiters(line_index,1) , line_delimiters(line_index,2) );
        
    
    %Pre Segment in Penups and Pendowns
    all_segments    = segment_by_penups_pendowns(Line);    
    n_segments_line = length(all_segments);
    
    stroke_index_in_line = -1;
    for k=1:n_segments_line
        if( are_words_equal( all_segments(k) , Stroke ) )
            stroke_index_in_line = k;
            break;
        end
    end 
    

end