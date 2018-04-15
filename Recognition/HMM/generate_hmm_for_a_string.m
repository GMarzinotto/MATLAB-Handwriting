function [ HMM_for_string ] = generate_hmm_for_a_string( a_string , HMM_chars_map )

    HMM_List = [];
    for k=1:length(a_string)
        HMM_List = [ HMM_List; HMM_chars_map( a_string(k) ) ];
    end

    HMM_for_string = concatenate_list_of_hmm_left_to_right( HMM_List );


end