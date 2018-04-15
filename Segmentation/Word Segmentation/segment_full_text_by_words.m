function [ Segmented_Word_List , Line_Segments ] = segment_full_text_by_words( Word )

    Line_Segments = segment_full_text_by_lines( Word );
    
    Segmented_Word_List = [ ];
    for k=1:length(Line_Segments)
        [ k_Segmented_Words ] = segment_line_by_words_with_iterative_criterion( Line_Segments(k) );
        Segmented_Word_List = [ Segmented_Word_List; k_Segmented_Words ];
    end
    
    
end