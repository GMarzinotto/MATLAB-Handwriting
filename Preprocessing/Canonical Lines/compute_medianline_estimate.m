function [ median_line_coefs ] = compute_medianline_estimate( Word , line_order , rm_outliers )


    [ baseline_coefs  ] = compute_baseline_estimate ( Word , line_order , rm_outliers );
    [ upperline_coefs ] = compute_upperline_estimate( Word , line_order , line_order );
    
    %Ensure both lines are the same order
    if( length(baseline_coefs) ~= length(upperline_coefs) )
        if( length(baseline_coefs) > length(upperline_coefs) )
            [ baseline_coefs  ] = compute_baseline_estimate ( Word , length(upperline_coefs)-1 , rm_outliers );
        else
            [ upperline_coefs ] = compute_upperline_estimate( Word , length(baseline_coefs)-1 , line_order );
        end
    end
    
    median_line_coefs = (baseline_coefs + upperline_coefs)/2.0;   
    

end