function [ UL_Grouping ] = compute_upperline_grouping_unidimensional_statistics( Word , upperline_coefs )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );

    if(nargin < 2) 
        if(strcmp(Word.ContentType,'LINE'))
            upperline_coefs = compute_upperline_estimate( Word , 1 , true );
        end
        if(strcmp(Word.ContentType,'WORD'))
            upperline_coefs = compute_upperline_estimate( Word , 0 , true );
        end
    end
    
    distances = compute_upperline_grouping_distances( Word , upperline_coefs );
    
   [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , kurt_val ] = compute_unidimensional_statistics(distances);

    UL_Grouping.mean       = avg_val;
    UL_Grouping.std        = std_val;
    UL_Grouping.min        = min_val;
    UL_Grouping.max        = max_val;
    UL_Grouping.range      = ran_val;
    UL_Grouping.percentils = per_val;
    UL_Grouping.skewness   = skew_val;
    UL_Grouping.kurtosis   = kurt_val;
    
end