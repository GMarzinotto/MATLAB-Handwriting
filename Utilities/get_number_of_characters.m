function [ num_characters ] = get_number_of_characters( Word )

    if(isfield(Word,'Label'))
        num_characters = length(Word.Label);
    else
        num_characters = 0;
        warning('Requested the number of characters of a word without labels! Returned 0');
    end
    
end

