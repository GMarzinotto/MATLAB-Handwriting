function [ Segmented_Word ] = segment_word_by_x_delimiters( Word_Line , Xmin , Xmax )

    [ all_segments , ~ , ~ , str_delim ] = segment_by_penups_pendowns( Word_Line );

    
    segments_in_range = [];
    k = 1;
    while ( k <= length(all_segments) )
        
        init_segment = k;
        while( k <= length(all_segments) && compute_percentage_of_word_between_bounds( all_segments(k) , Xmin , Xmax ) >= 0.5 )
            k = k + 1;
        end
        final_segment = k-1;
        
        if( final_segment >= init_segment )
            segments_in_range = [ segments_in_range; [ str_delim( init_segment , 1 )  str_delim( final_segment , 2 ) ] ];
        end
        
        while ( k <= length(all_segments) && compute_percentage_of_word_between_bounds( all_segments(k) , Xmin , Xmax ) <= 0.5 )
            k = k + 1;
        end
        
    end

    
    [ n_sub_words , ~ ] = size( segments_in_range );
    Sub_Words_List = [];
    for k = 1:n_sub_words
       kSub_Words = segment_using_separators( Word_Line , segments_in_range(k,1) , segments_in_range(k,2) );
       Sub_Words_List  = [Sub_Words_List; kSub_Words ]; 
    end
    
    if(~isempty(Sub_Words_List))
        Segmented_Word = combine_multiple_word_structs_under_same_timestamp( Sub_Words_List );
    else
        Segmented_Word = [];
    end
end