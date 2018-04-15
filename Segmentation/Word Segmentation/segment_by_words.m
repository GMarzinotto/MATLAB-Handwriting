function [ Segmented_Word_List ] = segment_by_words( Word )

    switch Word.ContentType
        case 'FULL_TEXT'
            [ Segmented_Word_List ] = segment_full_text_by_words( Word );
        case 'LINE'
             [ Segmented_Word_List ] = segment_line_by_words_with_iterative_criterion( Word );
        case 'WORD'
            warning('User tried to segment a word by words... Step was skip')
            Segmented_Word_List = Word;
        otherwise
            warning('User tried to segment something unknown by words... Step was skip')
            Segmented_Word_List = Word;
    end

    
end