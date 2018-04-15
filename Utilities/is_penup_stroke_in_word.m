function [ is_in_word , searched_stroke_index ] = is_penup_stroke_in_word( Word , Stroke )


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
        is_in_word = false;
    else
        is_in_word = true;
    end
    

end