function [] = plot_correlation_circle_lda(data,labels,feature_names,axis1,axis2)

    [ ~ , score , ~ ] = compute_linear_discriminant_analysis( data , labels );
    corcer(data,score,axis1,axis2,feature_names)

end