
all_features    = [];
all_labels      = false(0);

for i=1:length(Writers)
    
    iWriter = Writers(i);
    
    for j=1:2
        
        if(isfield(iWriter,strcat('Test',num2str(j))))
            
            jTest = eval(strcat('iWriter.Test',num2str(j),';'));
            if(isfield(jTest,'strokes_punctuation_marks'))

                [ ~ , ~ , pendown_segments, ~ ] = segment_by_penups_pendowns(jTest);
                
                for k=1:length(pendown_segments)
                    
                    
                    if(strcmp(jTest.strokes_diacritic_marks(k),'normal'))

                        curr_str_line = get_text_line_containing_stroke( jTest , pendown_segments(k)  );
                        [ ~ , ~ , ~ , ~ , ~ , Canonical_Lines ] = compute_canonical_lines_height_estimates_with_local_min_max( curr_str_line , 1 , true );
                        [ features , feature_names ] = compute_punctuation_marks_features_for_classifier( pendown_segments(k) , Canonical_Lines );

                        all_features            = [ all_features; features ];
                        all_labels      		= [ all_labels; (~strcmp(jTest.strokes_punctuation_marks{k},'normal')) ];
                
                    end
                end
            else
                error('Invalid Writer Test!')
            end
        end
        
    end  
    
end

class_names = [false true];
t = templateSVM('Standardize',1,'KernelFunction','gaussian');

SVM_punctuation_marks_boolean_model = fitcecoc( all_features ,all_labels,'ClassNames',class_names,'Learners',t,'FitPosterior',1);
                         
CVMdl = crossval(SVM_punctuation_marks_boolean_model);
oosLoss = kfoldLoss(CVMdl);
oofLabel = kfoldPredict(CVMdl);
ConfMat = confusionmat(all_labels,oofLabel);

[n,p] = size(all_features);
isLabels = [false true];
nLabels = numel(isLabels);
tabulate(categorical(all_labels))

% Convert the integer label vector to a class-identifier matrix.
[~,grp] = ismember(oofLabel,isLabels);
oofLabelMat = zeros(nLabels,n);
idxLinear = sub2ind([nLabels n],grp,(1:n)');
oofLabelMat(idxLinear) = 1; % Flags the row corresponding to the class

% Convert the integer label vector to a class-identifier matrix.
[~,grp] = ismember(all_labels,isLabels);
YMat = zeros(nLabels,n);
idxLinearY = sub2ind([nLabels n],grp,(1:n)');
YMat(idxLinearY) = 1;

figure;
plotconfusion(YMat,oofLabelMat);

all_labels_num = zeros(length(all_labels),1);

for k=1:length(class_names)
    all_labels_num( ismember(all_labels,class_names(k))) = k;
end


figure(),
plot_sne_components_scatter( all_features , all_labels_num , {'normal','punctuation'} )

