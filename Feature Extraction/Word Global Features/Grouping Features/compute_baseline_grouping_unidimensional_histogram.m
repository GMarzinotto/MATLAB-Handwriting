function [ BL_Grouping ] = compute_baseline_grouping_unidimensional_histogram( Word , n_bins , delimiters_type , hist_type , baseline_coefs  )


    Word = convert_word_to_a_new_tracking_type( Word, 'ON_TABLET' );

    if(nargin < 5) 
        if(strcmp(Word.ContentType,'LINE'))
            baseline_coefs = compute_baseline_estimate( Word , 1 , true );
        end
        if(strcmp(Word.ContentType,'WORD'))
            baseline_coefs = compute_baseline_estimate( Word , 0 , true );
        end
    end
      
    distances = compute_baseline_grouping_distances( Word , baseline_coefs );

    bin_loader = strcat('Bin_Delimiters_Baseline_Grouping_',num2str(n_bins),'bins');
    eval(bin_loader);
    
    delimiters = eval(strcat('Bins.Baseline_Grouping.Bins',num2str(n_bins),'.',delimiters_type));
    
    BL_Grouping  = a_good_histogram_function( distances , delimiters , hist_type );

end