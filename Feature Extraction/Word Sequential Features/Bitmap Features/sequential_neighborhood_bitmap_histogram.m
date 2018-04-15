function [ bin_vals_for_sequence , bin_vals_normalized ] = sequential_neighborhood_bitmap_histogram( Word , n_row_bins , n_col_bins )

    if(nargin < 2)
        n_row_bins = 3;
    end
    if(nargin < 3)
        n_col_bins = n_row_bins;
    end
    
    
    [ corpus_size ] = compute_corpus_size(Word);
    
    histogram_bin_x_length = corpus_size/(n_col_bins);
    histogram_bin_y_length = corpus_size/(n_row_bins);
    
    bin_vals_for_sequence = [];
    for i=1:Word.NumSamples
        bin_vals = [];
        for j=1:n_row_bins
            for k=1:n_col_bins
                
                low_x_border  = Word.X(i) + ( k - n_col_bins/2 - 1 )*histogram_bin_x_length;
                high_x_border = Word.X(i) + ( k - n_col_bins/2 )*histogram_bin_x_length;
                
                low_y_border  = Word.Y(i) + ( j - n_row_bins/2 - 1 )*histogram_bin_y_length;
                high_y_border = Word.Y(i) + ( j - n_row_bins/2 )*histogram_bin_y_length;
                
                bin_vals = [bin_vals length(find( Word.X >= low_x_border & Word.X <= high_x_border & Word.Y >= low_y_border & Word.Y <= high_y_border ))];
           
            end
        end
        bin_vals_for_sequence = [ bin_vals_for_sequence; bin_vals ];
    end
    
    bin_vals_normalized = [];
    for k=1:Word.NumSamples
        bin_vals_normalized = [ bin_vals_normalized; bin_vals_for_sequence(k,:)/sum(bin_vals_for_sequence(k,:)) ];
    end



end