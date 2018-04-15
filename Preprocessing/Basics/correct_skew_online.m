function [ no_skew_word ] = correct_skew_online( Word )



    no_skew_word = Word;
    XY_Word = [Word.X Word.Y];
    
    [ ~ , SCORE, ~ , ~ , EXPLAINED] = pca(XY_Word);
    
    if( abs(EXPLAINED(1)-EXPLAINED(2)) < 10 )
        warning('Skew Correction is unclear for this handwritten sample, word may be to small. therefore it is left unchanged')
    else
        no_skew_word.X = SCORE(:,1);
        no_skew_word.Y = SCORE(:,2);
    end



end