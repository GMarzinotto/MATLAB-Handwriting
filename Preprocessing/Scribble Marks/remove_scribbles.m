function [ Word_Without_Scribbles ] = remove_scribbles( Word )

    [ ~ , scribble_per_sample ] = detect_scribble_marks(Word);
    Word_Without_Scribbles = segment_by_word_subsample( Word , find(~scribble_per_sample) );
    
end