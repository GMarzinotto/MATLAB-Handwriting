function [ ML_Grouping ] = compute_medianline_grouping_unidimensional_statistics( Word , medianline_coefs )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );

    if(nargin < 2) 
        if(strcmp(Word.ContentType,'LINE'))
            medianline_coefs = compute_medianline_estimate( Word , 1 , true );
        end
        if(strcmp(Word.ContentType,'WORD'))
            medianline_coefs = compute_medianline_estimate( Word , 0 , true );
        end
    end
    
    distances = compute_medianline_grouping_distances( Word , medianline_coefs );

   [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , kurt_val ] = compute_unidimensional_statistics(distances);

    ML_Grouping.mean       = avg_val;
    ML_Grouping.std        = std_val;
    ML_Grouping.min        = min_val;
    ML_Grouping.max        = max_val;
    ML_Grouping.range      = ran_val;
    ML_Grouping.percentils = per_val;
    ML_Grouping.skewness   = skew_val;
    ML_Grouping.kurtosis   = kurt_val;

end