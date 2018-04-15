function [ full_vocabulary_map , char_vocabulary_map , word_vocabulary_map ] = generate_label_word_map( All_Words )


    full_vocabulary = unique({All_Words.Label});
    char_vocabulary = {};
    word_vocabulary = {};
    
    full_cell_vocabulary = {};
    char_cell_vocabulary = {};
    word_cell_vocabulary = {};
    
    idx_word = 1;
    idx_char = 1;
    for k = 1:length(full_vocabulary)
        kindexes =  strcmp({All_Words.Label}, full_vocabulary{k} ) ;
        full_cell_vocabulary{k} = All_Words(kindexes);
        
        if( strcmp( full_cell_vocabulary{k}(1).ContentType , 'CHARACTER' ) || strcmp( full_cell_vocabulary{k}(1).ContentType , 'DIGIT' ) )
            char_cell_vocabulary{ idx_char } = All_Words(kindexes);
            char_vocabulary{ idx_char } = full_vocabulary{k};
            idx_char = idx_char + 1;
        else
            word_cell_vocabulary{ idx_word } = All_Words(kindexes);  
            word_vocabulary{ idx_word } = full_vocabulary{k};
            idx_word = idx_word + 1; 
        end
        
    end
    
    full_vocabulary_map = containers.Map( full_vocabulary , full_cell_vocabulary );
    word_vocabulary_map = containers.Map( word_vocabulary , word_cell_vocabulary );
    char_vocabulary_map = containers.Map( char_vocabulary , char_cell_vocabulary );


end