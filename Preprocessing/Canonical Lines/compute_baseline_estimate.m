function [ baseline_coefs , local_minima , low_quality ] = compute_baseline_estimate( Word , line_order , rm_outliers , plot_warning_case )

    if(nargin < 2)
        line_order = 1;
    end
    
    if(nargin < 3)
        rm_outliers = false;
    end
    
    if(nargin < 4)
        plot_warning_case = false;
    end

    
    [ local_minima , ~ ] = compute_local_minima_and_local_maxima( Word , 'ON_TABLET' );
        
    [ baseline_coefs , low_quality ] = generic_canonical_line_regression( Word , local_minima , line_order , rm_outliers , plot_warning_case );
   
    while( low_quality && line_order > 0 )
        
        line_order = line_order - 1;
        warning('line regression quality is low, repeating the estimation with line_order = %d', line_order );
        [ baseline_coefs , low_quality ] = generic_canonical_line_regression( Word , local_minima , line_order , rm_outliers , plot_warning_case );

    end
    
    final_line_order = line_order;
    
    if( low_quality )
        warning('final line regression quality is low even with lineorder = 0')
    end
    
end