function [ UL_Grouping ] = compute_upperline_grouping_unidimensional_histogram( Word , n_bins , delimiters_type , hist_type , upperline_coefs )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );

    if(nargin < 5) 
        if(strcmp(Word.ContentType,'LINE'))
            upperline_coefs = compute_upperline_estimate( Word , 1 , true );
        end
        if(strcmp(Word.ContentType,'WORD'))
            upperline_coefs = compute_upperline_estimate( Word , 0 , true );
        end
    end
    
    distances = compute_upperline_grouping_distances( Word , upperline_coefs );
    
    bin_loader = strcat('Bin_Delimiters_Upperline_Grouping_',num2str(n_bins),'bins');
    eval(bin_loader);
    
    delimiters = eval(strcat('Bins.Upperline_Grouping.Bins',num2str(n_bins),'.',delimiters_type));
    
    UL_Grouping  = a_good_histogram_function( distances , delimiters , hist_type );
    
end