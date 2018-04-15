function [ Word_Corpus ] = extract_word_corpus( Word , line_order , rm_outliers )

    if(nargin < 2)
        line_order = 1;
    end
    if(nargin < 3)
        rm_outliers = true;
    end

    [ ~ , ~ , ~ , ~ , ~ , Canonical_Lines ] = compute_canonical_lines_height_estimates_with_local_min_max( Word , line_order , rm_outliers );
    
    points_in_word_corpus = [];
    for k = 1:Word.NumSamples
        
        poly_val_baseline  = polyval( Canonical_Lines.BaseLine , Word.X(k) );
        poly_val_upperline = polyval( Canonical_Lines.UpperLine , Word.X(k) );
        
        if( Word.P(k) > 0 && Word.Y(k) >= ( poly_val_baseline - 0.033*abs( poly_val_baseline ) ) && Word.Y(k) <= ( poly_val_upperline + 0.033*abs( poly_val_upperline ) ) )
            points_in_word_corpus = [ points_in_word_corpus; k ];
        end
    end

        
    Word_Corpus = segment_by_word_subsample( Word , points_in_word_corpus );
    
end