
% all_features    = [];
all_labels      = [];

for i=1:length(Writers)
    
    iWriter = Writers(i);
    
    for j=1:2
        
        if(isfield(iWriter,strcat('Test',num2str(j))))
            
            jTest = eval(strcat('iWriter.Test',num2str(j),';'));
            if(isfield(jTest,'is_delayed_stroke') && strcmp(jTest.Tracking,'ON_TABLET') )

                [ ~ , ~ , pendown_segments, ~ ] = segment_by_penups_pendowns(jTest);
                for k=2:length(pendown_segments) - 1

                    
                    
                    [ features , feature_names ] = compute_delayed_strokes_features_for_classifier( jTest , pendown_segments(k-1) , pendown_segments(k) , pendown_segments(k+1) );
 
                    all_features    = [ all_features; features ];
                    all_labels      = [ all_labels; jTest.is_delayed_stroke(k) ];

                end

            else
                error('Invalid Writer Test!')
            end
        end
        
    end  
    
end

[z_features,MU,SIGMA] = zscore(all_features);
[COEFF, z_scores]     = pca(z_features);
n_coeff_comp          = 15;

SVM_delayed_strokes_model = fitcsvm( z_features(:,1:n_coeff_comp) , all_labels,'ClassNames',[false true],'Standardize',true,'KernelFunction','rbf');

CVSVMModel = crossval(SVM_delayed_strokes_model);
classLoss = kfoldLoss(CVSVMModel);


sv = SVM_delayed_strokes_model.SupportVectors;
figure(),
plot_sne_components_scatter( z_features(:,1:n_coeff_comp) ,all_labels+1,{'normal','delayed'})

