function [ newWord ] = rescale_word( Word )

    [  ~ , base_height , upper_height  ] = compute_canonical_lines_height_estimates_with_local_min_max(Word, 0 , true );
    
    scalingFactor = upper_height - base_height;
    
    newWord = Word;
    
    newWord.X = Word.X/scalingFactor;
    newWord.X = Word.X/scalingFactor;


end