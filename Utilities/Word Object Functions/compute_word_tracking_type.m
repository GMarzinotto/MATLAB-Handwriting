function [ type ] = compute_word_tracking_type(Word)

    if(sum(Word.P)==0)
        %Word Contains Only ON_AIR data
        type = 'ON_AIR';
    else
        if(sum(Word.P==0)==0)
            %Word Contains Only ON_TABLET data
            type = 'ON_TABLET';
        else
            %Word Contains Both ON_TABLET & ON_AIR data
            type = 'ON_TABLET_ON_AIR';
        end
    end

end