function [ median_line_dist , base_line_dist , upper_line_dist , minimum_line_dist , maximum_line_dist ] = distance_to_canonical_lines( Word , line_order , rm_outliers )



    [ ~ , ~ , ~ , ~ , ~ , Canonical_Lines  ] = compute_canonical_lines_height_estimates_with_local_min_max( Word , line_order , rm_outliers );

    median_line_dist    = Word.Y - polyval( Canonical_Lines.MedianLine , Word.X );
    base_line_dist      = Word.Y - polyval( Canonical_Lines.BaseLine , Word.X );
    upper_line_dist     = Word.Y - polyval( Canonical_Lines.UpperLine , Word.X );
    minimum_line_dist   = Word.Y - polyval( Canonical_Lines.Minimum , Word.X );
    maximum_line_dist   = Word.Y - polyval( Canonical_Lines.Maximum , Word.X );
    

end