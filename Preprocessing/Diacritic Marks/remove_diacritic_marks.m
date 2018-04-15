function [ Word_No_Diacritics ] = remove_diacritic_marks( Word )

    [ ~ , diacritic_samples_labels ] = detect_diacritic_marks(Word);
    Word_No_Diacritics = segment_by_word_subsample( Word , find(~diacritic_samples_labels) );

end