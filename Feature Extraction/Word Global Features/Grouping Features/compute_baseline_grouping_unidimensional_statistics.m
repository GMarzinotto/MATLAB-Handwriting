function [ BL_Grouping ] = compute_baseline_grouping_unidimensional_statistics( Word , baseline_coefs  )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );

    if(nargin < 2) 
        if(strcmp(Word.ContentType,'LINE'))
            baseline_coefs = compute_baseline_estimate( Word , 1 , true );
        end
        if(strcmp(Word.ContentType,'WORD'))
            baseline_coefs = compute_baseline_estimate( Word , 0 , true );
        end
    end
      
    distances = compute_baseline_grouping_distances( Word , baseline_coefs );

   [avg_val , std_val , min_val , max_val , ran_val , per_val , skew_val , kurt_val ] = compute_unidimensional_statistics(distances);

    BL_Grouping.mean       = avg_val;
    BL_Grouping.std        = std_val;
    BL_Grouping.min        = min_val;
    BL_Grouping.max        = max_val;
    BL_Grouping.range      = ran_val;
    BL_Grouping.percentils = per_val;
    BL_Grouping.skewness   = skew_val;
    BL_Grouping.kurtosis   = kurt_val;

end