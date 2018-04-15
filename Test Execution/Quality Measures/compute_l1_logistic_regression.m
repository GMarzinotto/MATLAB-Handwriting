function [ all_cross_valid_error , model_coefficients ] = compute_l1_logistic_regression( features , labels , lambda)


    [Npoints,Nfeatures] = size(features);
    max_labels = length(unique(labels));
    
    model_coefficients  = zeros( Nfeatures , max_labels );
    all_cross_valid_error = zeros( 1 , max_labels );
    
    if( max_labels == 2 )
        [ model_2 , FitInfo] = lassoglm(features,labels == 1 ,'binomial','Lambda',lambda,'CV',20);
        model_coefficients(:,1) = model_2;
        model_coefficients(:,2) = -1*model_2;
        all_cross_valid_error(1) = FitInfo.SE;
        all_cross_valid_error(2) = FitInfo.SE;
    else if( max_labels > 2 )
            for k=1:max_labels
                klabel = (labels == k);
                [ k_model , FitInfo] = lassoglm(features,klabel,'binomial','Lambda',lambda,'CV',20);
                model_coefficients(:,k) = k_model;
                all_cross_valid_error(k) = FitInfo.SE;
            end
        else
            error ('invalid number of classes!')
        end           
    end
    
end