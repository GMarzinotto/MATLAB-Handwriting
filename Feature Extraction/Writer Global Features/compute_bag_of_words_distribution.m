function [ bag_of_words_distribution ] = compute_bag_of_words_distribution( all_word_indexes_from_writer , max_index )


    n_words_writer = 1.0*length(all_word_indexes_from_writer(:,1));
    
    %distribuion across the previous layer
    %bag_of_words_distribution = zeros( 1 , max_index );
    for k=1:max_index
        eval( strcat('bag_of_words_distribution.cluster' , int2str(k) ,' = length( all_word_indexes_from_writer ==', int2str(k),')/n_words_writer;'))
    end

    
    
end