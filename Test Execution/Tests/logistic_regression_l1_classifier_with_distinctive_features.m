function [ cross_valid_errors , model_coefficients ] = logistic_regression_l1_classifier_with_distinctive_features( features , labels , features_names , labels_names )


    [~,Nfeatures] = size(features);
    lambda = 0.25/Nfeatures;
    
    max_labels = length(unique(labels));
    
    if( max_labels > 3 || max_labels < 2 )
        error('Label vector can only have 2 or 3 classes')
    end
    
    [ cross_valid_errors , model_coefficients ] = compute_l1_logistic_regression( features , labels , lambda);
    
    if( max_labels == 3 )
        if(nargin < 4)
            plot_model_feature_coefficients_with_3_classes( model_coefficients);
        else
            plot_model_feature_coefficients_with_3_classes( model_coefficients , features_names , labels_names);
        end
    else if ( max_labels == 2 )
            if(nargin < 4 )
                plot_model_feature_coefficients_with_2_classes( model_coefficients );
            else
                plot_model_feature_coefficients_with_2_classes( model_coefficients , features_names , labels_names);
            end
        end
    end
    
end