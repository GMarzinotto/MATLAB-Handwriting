function [ coefficients , low_quality ] = generic_canonical_line_regression( Word , local_min_xor_max , line_order , rm_outliers , plot_warning_case )


    descriptors = ones(size(local_min_xor_max.X));
    for k=1:line_order
        descriptors = [ descriptors(:,1).*local_min_xor_max.X      descriptors ];
    end
    

   %If remove outliers 
   if(rm_outliers)
       outliers = -1;
       while( ~isempty(outliers) )
           [ coefficients , ~ , ~ , rint , ~ ] = regress(local_min_xor_max.Y,descriptors);
           outliers = find(sign(rint(:,1))==sign(rint(:,2)));
           local_min_xor_max.X(outliers) = [];
           local_min_xor_max.Y(outliers) = [];
           descriptors(outliers,:)  = [];
       end
   %Otherwise, just apply one linear regression
   else
       coefficients = regress(local_min_xor_max.Y,descriptors);
   end

   
    n_min_max = length(local_min_xor_max.X);
    
   %If line estimate is uncertain, plot the estimate for further analysis
   if( n_min_max < power(line_order,2) + 4 )
        if(plot_warning_case)
            warning('Canonical Line Estimate may not be a good estimate as only used %d local min/max! See Plot:', n_min_max )
            figure(),
            hold on
            plot_in_black_and_white(Word)
            scatter(local_min_xor_max.X,local_min_xor_max.Y,[],'r');
            x_range = [min(Word.X):0.1:max(Word.X)];
            plot(x_range,polyval(upperline_coefs,x_range));
        end
       low_quality = true;
   else
       low_quality = false;
   end
   

end