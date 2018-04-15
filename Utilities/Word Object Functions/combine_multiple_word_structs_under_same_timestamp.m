function [ Combined_Word ] = combine_multiple_word_structs_under_same_timestamp( Word_List , safe_mode )

    if( nargin < 2 ) 
        safe_mode = true;
    end

    Combined_Word = Word_List(1);
    for k = 2:length(Word_List)
       Combined_Word =  combine_two_word_structs_under_same_timestamp( Combined_Word , Word_List(k) , safe_mode );
    end
    
end