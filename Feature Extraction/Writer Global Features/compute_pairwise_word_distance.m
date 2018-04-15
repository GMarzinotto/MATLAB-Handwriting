function [ pairwise_distances ] = compute_pairwise_word_distance( all_word_features_from_writer )

    n_words_writer = length(all_word_features_from_writer(:,1));
    
    
    pairwise_distances = [];
    for k=1:n_words_writer
        for j=k+1:n_words_writer
            pairwise_distances = [ pairwise_distances   norm(all_word_features_from_writer(k,:) - all_word_features_from_writer(j,:)) ];
        end
    end
    

end