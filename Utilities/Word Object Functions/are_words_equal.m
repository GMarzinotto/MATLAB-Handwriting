function [equal] = are_words_equal(Word1,Word2)

    
    
    if (  ( length(Word1.X) ~= length(Word2.X)) || ( length(Word1.Y) ~= length(Word2.Y)) || (length(Word1.P) ~= length(Word2.P))  ||  ... 
               ~isequal(Word1.X,Word2.X)        ||       ~isequal(Word1.Y,Word2.Y)       ||      ~isequal(Word1.P,Word2.P) )
        equal = false;
    else 
        equal = true;
    end


end