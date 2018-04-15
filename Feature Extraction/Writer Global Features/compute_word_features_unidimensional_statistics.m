function [ Writer_Word_Stats ] = compute_word_features_unidimensional_statistics( all_word_features_from_writer )

    [avg_val , std_val , min_val, max_val , ran_val , per_obj , skew_val , kurt_val ] = compute_unidimensional_statistics( all_word_features_from_writer );
    
    Writer_Word_Stats.mean       = avg_val;
    Writer_Word_Stats.std        = std_val;
    Writer_Word_Stats.min        = min_val;
    Writer_Word_Stats.max        = max_val;
    Writer_Word_Stats.range      = ran_val;
    Writer_Word_Stats.percentils = per_obj;
    Writer_Word_Stats.skewness   = skew_val;
    Writer_Word_Stats.kurtosis   = kurt_val;

end