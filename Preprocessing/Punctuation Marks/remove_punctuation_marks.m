function [ Word_Without_Punctuation ] = remove_punctuation_marks( Word )

    [ ~ , punctuation_samples_labels ] = detect_punctuation_marks(Word);
    Word_Without_Punctuation = segment_by_word_subsample( Word , find(~punctuation_samples_labels) );

end