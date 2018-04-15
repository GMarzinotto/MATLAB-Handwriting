function [ Line_List ] = segment_by_lines( Word , verbose )

    if(nargin < 2)
       verbose = false; 
    end

    switch Word.ContentType
        case 'FULL_TEXT'
            Line_List = segment_full_text_by_lines( Word );
        case 'LINE'
            if(verbose) 
                warning('User tried to segment a line by lines... Step was skip') 
            end
            Line_List =  Word;
        case 'WORD'
            warning('User tried to segment a word by lines... Step was skip') 
            Line_List = Word;
        otherwise
            warning('User tried to segment something unknown by lines... Step was skip')
            Line_List = Word;
    end

    
end