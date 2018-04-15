function [ labels_per_stroke , labels_per_sample ] = detect_delayed_strokes( Word )

   
    [ all_segments , ~ , pendown_segments ]   = segment_by_penups_pendowns(Word);
    
    all_features = [];
    for k=2:length(pendown_segments)-1
        features  = compute_delayed_strokes_features_for_classifier( Word, pendown_segments(k-1) , pendown_segments(k) , pendown_segments(k+1) );
        all_features = [ all_features; features ];
    end
    
    load('SVM_delayed_strokes_model.mat')
    
    centered_features = all_features - repmat(MU , length(pendown_segments)-2 , 1 );
    reduced_features  = centered_features ./ repmat( SIGMA , length(pendown_segments)-2 , 1 ) ;
    proyect_features  = reduced_features*COEFF;
    final_features    = proyect_features(:,1:n_coeff_comp);
    
    labels_on_tablet = predict(SVM_delayed_strokes_model,final_features);
    labels_on_tablet = [false; labels_on_tablet; false];

    
    
    labels_per_stroke = false(0); 
    labels_per_sample = false(0);
    idx_stroke = 1;
    idx_sample = 1;
    for k=1:length(all_segments)
        if(strcmp(all_segments(k).Tracking,'ON_TABLET'))
            labels_per_stroke(k) = labels_on_tablet(idx_stroke);
            labels_per_sample( idx_sample:(idx_sample + all_segments(k).NumSamples -1 ) ) = labels_on_tablet(idx_stroke);
            idx_stroke = idx_stroke + 1;
            
        else
            labels_per_stroke(k) = false;
            labels_per_sample( idx_sample:(idx_sample + all_segments(k).NumSamples -1 ) ) = false;
        end
        idx_sample = idx_sample + all_segments(k).NumSamples;
    end
    

end