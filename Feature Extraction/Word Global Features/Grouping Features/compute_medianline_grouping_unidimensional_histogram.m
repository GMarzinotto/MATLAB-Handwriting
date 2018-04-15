function [ ML_Grouping ] = compute_medianline_grouping_unidimensional_histogram( Word , n_bins , delimiters_type , hist_type , medianline_coefs )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );

    if(nargin < 5) 
        if(strcmp(Word.ContentType,'LINE'))
            medianline_coefs = compute_medianline_estimate( Word , 1 , true );
        end
        if(strcmp(Word.ContentType,'WORD'))
            medianline_coefs = compute_medianline_estimate( Word , 0 , true );
        end
    end
    
    distances = compute_medianline_grouping_distances( Word , medianline_coefs );

    bin_loader = strcat('Bin_Delimiters_Medianline_Grouping_',num2str(n_bins),'bins');
    eval(bin_loader);
    
    delimiters = eval(strcat('Bins.Medianline_Grouping.Bins',num2str(n_bins),'.',delimiters_type));
    
    ML_Grouping  = a_good_histogram_function( distances , delimiters , hist_type );

end