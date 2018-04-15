function [ all_features_words ] = replace_NaN_with_person_average( all_features_words , all_words_IDs )


    [ ~ , nb_features ] = size(all_features_words);
    unique_ids = unique( all_words_IDs );

    for j=1:length(unique_ids)
        person_indexes =  find( strcmp( all_words_IDs , unique_ids{j} ) );
        for k=1:nb_features
            nan_indexes = find( isnan( all_features_words(person_indexes,k) )  );
            if( ~isempty(nan_indexes) )
                all_features_words( person_indexes(nan_indexes) , k ) = nanmean( all_features_words(person_indexes,k) );
            end
        end
    end



end