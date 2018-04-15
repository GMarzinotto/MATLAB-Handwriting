function [] = plot_model_feature_coefficients_with_3_classes( model_coefficients , features_names , labels_names)
%% plot_model_feature_coefficients_with_3_classes
%  Plots the coefficients of a discriminant model where you have 3 classes.
%  Coefficients are represented with dots that goes towards the class
%  where their tend to take possitive values.
%  If data is Z normalized, the distance to the origin represents 
%  the importance of the feature for the discrimination
%
% [ ] = _*plot_model_feature_coefficients_with_3_classes*_ ( _model_coefficients_ , _features_names_ , _labels_names_ )
%
%%% Inputs
% 
% * *model_coefficients*  : A matrix containing the features for each data sample
%
% * *features_names* : a cell array what contains the names of each feature
%
% * *labels_names* : a cell array what contains the names of each label
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if (nargin < 2)
        for k=1:size(model_coefficients,1)
            features_names{k} = {strcat('F',num2str(k))};
        end
    end

    if(nargin < 3)
        labels_names = { 'Group1' , 'Group2' , 'Group3' };
    end
    
    
    if( length(model_coefficients) == length(features_names) && size(model_coefficients,2)==3 )

        unit_vects  = [-sqrt(3)/2  1/2; sqrt(3)/2  1/2; 0 -1];
        
        for k=1:length(model_coefficients)
            param_pos(k,:) = model_coefficients(k,1)*unit_vects(1,:) + model_coefficients(k,2)*unit_vects(2,:) + model_coefficients(k,3)*unit_vects(3,:);
        end
        
        max_x = max(param_pos(:,1));
        max_y = max(param_pos(:,2));
        min_x = min(param_pos(:,1));
        min_y = min(param_pos(:,2));
        
        max_abs_x = max(abs([max_x  min_x]));
        max_abs_y = max(abs([max_y  min_y]));
        total_max = max(max_abs_x,max_abs_y)*3;
        
        
        axis([-1*(total_max) (total_max) -1*(total_max) (total_max)]);
        hold on
        g1_fill = fill(total_max*[0 -1/sqrt(3) -1/sqrt(3) 0],total_max*[2/3 2/3 -1/3  0 ],[1 0 0]); 
        set(g1_fill,'FaceAlpha',0.15)
        g2_fill = fill(total_max*[1/sqrt(3) 1/sqrt(3) 0 0],total_max*[-1/3 2/3  2/3 0],[0 1 0]); 
        set(g2_fill,'FaceAlpha',0.15)
        g3_fill = fill(total_max*[1/sqrt(3) 1/sqrt(3) -1/sqrt(3)  -1/sqrt(3) 0],total_max*[-1/3  -2.2/3  -2.2/3  -1/3  0],[0 0 1]); 
        set(g3_fill,'FaceAlpha',0.15)

        
        
        relevan_feat = find( param_pos(:,1) ~= 0 & param_pos(:,2) ~= 0 );
        scatter(param_pos(relevan_feat,1),param_pos(relevan_feat,2),'k*');
        text(param_pos(relevan_feat,1),param_pos(relevan_feat,2), {features_names{ relevan_feat } }, 'HorizontalAlignment' ,'center','FontWeight','bold','FontSize', 12 );
        
        
        text(-total_max/3 ,total_max/2, labels_names{1} , 'HorizontalAlignment' ,'center','FontWeight','bold','FontSize', 12 );
        text( total_max/3 ,total_max/2, labels_names{2} , 'HorizontalAlignment' ,'center','FontWeight','bold','FontSize', 12 );
        text(0 , -1*total_max/2 , labels_names{3} , 'HorizontalAlignment' ,'center','FontWeight','bold','FontSize', 12 );
        
        

    else
        error('Invalid plot')
    end
    

end