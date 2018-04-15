function [ final_hmm ] = concatenate_list_of_hmm_left_to_right( list_of_hmm )

    final_hmm = list_of_hmm(1);
    for k = 2:length(list_of_hmm)
        final_hmm = concatenate_two_hmm_left_to_right( final_hmm , list_of_hmm(k) );
    end

end