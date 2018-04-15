function [ Segments_Split_By_Punctuation ] = segment_line_by_punctuation_marks( Lines_Word )

    [ strokes_classes , ] = classify_punctuation_marks(Lines_Word);

    [ all_strokes ] = segment_by_penups_pendowns(Lines_Word);
    punct_marks = all_strokes(  ~strcmp(strokes_classes,'normal')  );
    
    Segments_Split_By_Punctuation = [];
    
    if(isempty(punct_marks) )
        
        Segments_Split_By_Punctuation = Lines_Word;
        
    else
        
        [ Word_Without_Punctuation ] = remove_punctuation_marks( Lines_Word );
        
            
        low_x  = min(Lines_Word.X);
         
        for k=1:length(punct_marks) 
            
            high_x = ( min(punct_marks(k).X) - 0.1 );
            
            [ Segment ] = segment_by_word_subsample( Word_Without_Punctuation , find( Word_Without_Punctuation.X >= low_x &  Word_Without_Punctuation.X < high_x ) );
            
            %%TODO: Add condition to check that the segment is large enough
            if( true )
                Segments_Split_By_Punctuation = [ Segments_Split_By_Punctuation; Segment ];
            end
            
            if( k == length(punct_marks) )

                [ Segment ] = segment_by_word_subsample( Word_Without_Punctuation , find( Word_Without_Punctuation.X >= high_x ) );
                
                %%TODO: Add condition to check that the segment is large enough
                if( true )
                    Segments_Split_By_Punctuation = [ Segments_Split_By_Punctuation; Segment ];
                end            
            end
            
            low_x = ( max(punct_marks(k).X) + 0.1 );
            
        end
    end


end