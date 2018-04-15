function [ criterion_val ] = compute_word_segmentation_criterion_value( space_sizes , text_sizes , spaces_to_segment , n_strokes_medianline )

    %text_length = sum(text_sizes);
    unselected_index  = setdiff( [1:length(space_sizes)] , spaces_to_segment );
    
    intra_word_spaces = space_sizes( unselected_index );
    inter_word_spaces = space_sizes( spaces_to_segment );
    
    delimiters = [ 0; spaces_to_segment; length(text_sizes) ] ;
    delimiters = sort(delimiters);
    
    pseudo_words_sizes = [];
    for k=1:length(delimiters)-1       
        kword_size = sum( text_sizes( (delimiters(k)+1):(delimiters(k+1)) )) + sum( space_sizes( (delimiters(k)+1):(delimiters(k+1)-1) ) );
        pseudo_words_sizes = [pseudo_words_sizes; kword_size];
    end

    
    %criterion_val = sum(intra_word_spaces) + 0.05*std( pseudo_words_sizes ) + 0.05*std( inter_word_spaces ) + 20*length(spaces_to_segment)/(n_strokes_medianline + 15);
    %criterion_val = sum(intra_word_spaces) + 0.05*std( pseudo_words_sizes ) + 0.05*std( inter_word_spaces ) + 0.25*length(spaces_to_segment);

    criterion_val = sum(intra_word_spaces) + 0.05*std( pseudo_words_sizes ) + 0.05*std( inter_word_spaces ) + length(spaces_to_segment)*( exp(-0.1*n_strokes_medianline)+0.25 );

end