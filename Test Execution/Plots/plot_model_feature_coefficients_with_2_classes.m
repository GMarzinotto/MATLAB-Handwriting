function [] = plot_model_feature_coefficients_with_2_classes( model_coefficients , features_names , labels_names)
%% plot_model_feature_coefficients_with_2_classes
%  Plots the coefficients of a discriminant model where you have 2 classes.
%  Coefficients are represented with a bar that goes towards the class
%  where their tend to take possitive values.
%  If data is Z normalized, the size of the bar represents the importance
%  of the feature for the discrimination
%  This function can also be use to plot linear regression coefficients
%  where there are implicitely considered two types of features. 
%  The features that increase the dependent variable and 
%  the features that decrease it 
%
% [ ] = _*plot_model_feature_coefficients_with_2_classes*_ ( _model_coefficients_ , _features_names_ , _labels_names_ )
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
        for k=1:length(model_coefficients)
            features_names{k} = {strcat('F',num2str(k))};
        end
    end

    if(nargin < 3)
        labels_names = { 'Negative' , 'Possitive' };
    end

    if(length(model_coefficients(1,:)) == 2 )
        model_coefficients(:,2) = [];
    else if ( size(model_coefficients(1,:)) > 2 )
            error('Maximum number of clases is 2!')
        end
    end
    
    if( length(model_coefficients) == length(features_names) )

        barh(model_coefficients)
        max_right = max(model_coefficients);
        max_left  = min(model_coefficients);
        
        maxLeftRight = max(abs([max_left max_right]));
        axis([-1*(maxLeftRight*1.2) (maxLeftRight*1.2) 0  (length(model_coefficients)+1.5)])
        
        x = zeros(1,length(model_coefficients));
        y = [1:length(model_coefficients)];
        text( x , y , features_names, 'HorizontalAlignment' ,'center','FontWeight','bold','FontSize', max(20 - length(model_coefficients),5) );
        
        text( -1*(maxLeftRight*0.6) , length(model_coefficients)+1 , labels_names{1} , 'HorizontalAlignment' ,'center','FontWeight','bold','FontSize', max(20 - length(model_coefficients),5) );
        text( (maxLeftRight*0.6)    , length(model_coefficients)+1 , labels_names{2} , 'HorizontalAlignment' ,'center','FontWeight','bold','FontSize', max(20 - length(model_coefficients),5) );

    else
        error('Invalid plot')
    end
end