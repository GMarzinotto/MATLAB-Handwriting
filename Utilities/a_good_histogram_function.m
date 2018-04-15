function [ Histogram ] = a_good_histogram_function( unidim_data , delimiters , thresholding , default_values )

    if( ~ issorted( delimiters ))
        delimiters = sort(delimiters);
    end
    
    if(strcat(thresholding,'Basic'))
        histogram_vals = histcounts(unidim_data,[-inf delimiters inf],'Normalization','probability');
        for k=1:length(histogram_vals)
            if(~isnan(histogram_vals(k)))
                eval(strcat('Histogram.bin',num2str(k),' = histogram_vals(',num2str(k),');'));
            else
                eval(strcat('Histogram.bin',num2str(k),' = 0;'));
            end
        end
    else
        error('Unsupported Histogram Type');
    end

end