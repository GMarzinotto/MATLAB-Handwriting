function [ Segmented_Word_List ] = segment_line_by_words_with_iterative_criterion( Word_Line )

    %Some Preprocessing to ensure the spaces are not affected by
    %punctuation marks, diacritics or scribble marks
    Word_Line = remove_punctuation_marks(Word_Line);
    Preproced_Word_Line = remove_diacritic_marks(Word_Line);
    Preproced_Word_Line = remove_scribbles(Preproced_Word_Line);
    
    % Compute the number of strokes passing through the median line as it
    % is involved in the calcule of the cost function...
    n_strokes_medianline  = compute_number_of_strokes_passing_through_corpus( Preproced_Word_Line , 'ON_TABLET' );
    
    %Extract corpust to avoid problems due to slant.
    WordCorpus = extract_word_corpus( Preproced_Word_Line );
    
    %Compute the horizontal spacing using the corpus
    [ space_size , texts_size , space_start_position , ~ ] = compute_horizontal_box_spacing( WordCorpus );
    
    
    

       
    %inter_word_spaces hold the indexes from spaces labelled as spaces between words
    inter_word_spaces = [];
    criterion_val_prev = inf;
    criterion_val_new  = sum( space_size );
    while( ( criterion_val_prev > criterion_val_new) && ( length(inter_word_spaces) < length(space_size) ) ) 
       
        % Find the space that maximizes the criterion from the remaining space
        unselected_index  = setdiff( [1:length(space_size)] , inter_word_spaces );
        
        % For each unselected space, we compute it's criterion value
        criterion_vals = [];
        for k=1:length(unselected_index)
            k_inter_word_spaces  = [ inter_word_spaces;  unselected_index(k) ];
            k_criterion_val = compute_word_segmentation_criterion_value( space_size , texts_size , k_inter_word_spaces , n_strokes_medianline );
            criterion_vals = [criterion_vals; k_criterion_val];
        end
        
        min_criterion_space = unselected_index( criterion_vals == min(criterion_vals) );
        
        if(length(min_criterion_space) > 1)
           min_criterion_space = min_criterion_space( min_criterion_space == max(space_size(min_criterion_space)) ); 
           if(length(min_criterion_space) > 1)
               min_criterion_space = min_criterion_space(1);
           end
        end
        
        inter_word_spaces = [ inter_word_spaces;  min_criterion_space ];
        criterion_val_prev = criterion_val_new;
        criterion_val_new  = compute_word_segmentation_criterion_value( space_size , texts_size , inter_word_spaces , n_strokes_medianline );
    
    end
    
    %remove last space because it causes an increase in the criterion value
    inter_word_spaces(end) = [];

    %sort the spaces to segment
    inter_word_spaces = sort(inter_word_spaces);
    
    %convert the indexes of the spaces into corresponding X coordinates
    x_coordinates_to_split =  space_start_position(inter_word_spaces) + space_size(inter_word_spaces)/2;
    
    %add the leftmost and the rightmost x values; 
    x_coordinates_to_split = [ min(Word_Line.X)-0.1;  x_coordinates_to_split;  max(Word_Line.X)+0.1 ];
    
    
    
    bool_is_word_large_enough = false(0);
    Segmented_Word_List = [];
    for k=1:length( x_coordinates_to_split )-1
        kWord =  segment_word_by_x_delimiters( Word_Line , x_coordinates_to_split(k) , x_coordinates_to_split(k+1) );
        if( ~isempty( kWord ) ) 
            if ( is_word_large_enough( kWord ) )
                kWord.ContentType = 'WORD';
                Segmented_Word_List = [ Segmented_Word_List; kWord ];
                bool_is_word_large_enough = [bool_is_word_large_enough; true ];
            else
                kWord.ContentType = 'WORD';
                Segmented_Word_List = [ Segmented_Word_List; kWord ];
                bool_is_word_large_enough = [bool_is_word_large_enough; false ];
            end
        end
    end
    

    
    while( ~is_word_large_enough(Segmented_Word_List(1)) )
        [ Combined_Word ] = combine_two_word_structs_under_same_timestamp( Segmented_Word_List(1) , Segmented_Word_List(2) , false );
        Segmented_Word_List(2) = Combined_Word;
        Segmented_Word_List(1) = [];
        bool_is_word_large_enough(1) = [];
        inter_word_spaces(1) = [];
    end
    if( ~isempty(bool_is_word_large_enough) )
        bool_is_word_large_enough(1) = true;
    end
    
    while( ~is_word_large_enough(Segmented_Word_List( end )) )
        [ Combined_Word ] = combine_two_word_structs_under_same_timestamp( Segmented_Word_List(end-1) , Segmented_Word_List(end) , false );
        Segmented_Word_List(end-1) = Combined_Word;
        Segmented_Word_List(end) = [];
        bool_is_word_large_enough(end) = [];
        inter_word_spaces(end) = [];
    end
    if( ~isempty(bool_is_word_large_enough) )
        bool_is_word_large_enough(end) = true;
    end
    
    
    short_words = flip ( find( ~bool_is_word_large_enough  ) );
    %for the short words we'll combine them with the closest word
    for idx = 1:length(short_words)
        
        k = short_words(idx);

        if( ~bool_is_word_large_enough(k) )
            if( space_size(inter_word_spaces(k-1)) > space_size(inter_word_spaces(k)) )
                [ Combined_Word ] = combine_two_word_structs_under_same_timestamp( Segmented_Word_List(k)   , Segmented_Word_List(k+1) , false );
                bool_is_word_large_enough(k) = [];
                Segmented_Word_List(k)  = [];
                Segmented_Word_List(k) =   Combined_Word;
                bool_is_word_large_enough(k) = is_word_large_enough(Combined_Word);
            else
                [ Combined_Word ]  = combine_two_word_structs_under_same_timestamp( Segmented_Word_List(k-1) , Segmented_Word_List(k)   , false );
                bool_is_word_large_enough(k) = [];
                bool_is_word_large_enough(k-1) = is_word_large_enough(Combined_Word);
                Segmented_Word_List(k)  = [];
                Segmented_Word_List(k-1) =   Combined_Word;
            end          
        end
    end
    
    
    %Plot to verify the result
%     figure(),
%     subplot(3,1,1), plot_in_black_and_white(WordCorpus);
%     subplot(3,1,2), plot_in_black_and_white(Preproced_Word_Line);
%     hold on   
%     for k=1:length(x_coordinates_to_split)
%        plot( [ x_coordinates_to_split(k) x_coordinates_to_split(k) ] , [ max(Word_Line.Y) min(Word_Line.Y) ] ) 
%     end
%     subplot(3,1,3), plot_in_black_and_white(Preproced_Word_Line);
%     hold on   
%     for k=1:length( Segmented_Word_List )
%         if(mod(k,2))
%             plot_in_black_and_white( Segmented_Word_List(k) , PlotStyle() , 'r' ); 
%         else
%             plot_in_black_and_white( Segmented_Word_List(k) , PlotStyle() , 'b' );
%         end
%     end
%      
    
end