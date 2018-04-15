function [ Pairwise_Distances ] = compute_pairwise_word_distance_unidimensional_statistics( all_word_features_from_writer )

    pairdist = compute_pairwise_word_distance( all_word_features_from_writer );
    
    [avg_val , std_val , min_val, max_val , ran_val , per_obj , ske_val , kur_val ] = compute_unidimensional_statistics( pairdist );

    
    Pairwise_Distances.mean       = avg_val;
    Pairwise_Distances.std        = std_val;
    Pairwise_Distances.min        = min_val;
    Pairwise_Distances.max        = max_val;
    Pairwise_Distances.range      = ran_val;
    Pairwise_Distances.percentils = per_obj;
    Pairwise_Distances.skewness   = ske_val;
    Pairwise_Distances.kurtosis   = kur_val;
    
    
end