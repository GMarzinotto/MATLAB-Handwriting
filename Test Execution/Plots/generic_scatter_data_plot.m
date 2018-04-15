function [ plot_obj ] = generic_scatter_data_plot( score , labels , category_names , axis1 , axis2 , secondary_binary_label )
%% generic_scatter_data_plot
%  Plots a scatter using colors that represents each label
%  user my give explicitly the name of each label
%  and also especify which axes from score matrix should be plot
%
% [ ] = _*generic_scatter_data_plot*_ ( _score_ , _labels_ , _category_names_ , _axis1_ , _axis2_ )
%
%%% Inputs
% 
% * *score*  : A matrix containing the scores for each data sample
%
% * *labels* : An integer list representing the labels of the points
%              list must start at 1 for the first class and don't skip
%              number
%
% * *category_names* : a cell array what contains the name of each label
%
% * *axis1* : index of the X axis in the plot
%
% * *axis2* : index of the Y axis in the plot
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if(nargin < 6 ) 
        secondary_binary_label = false(size(labels));
    end

    colors = distinguishable_colors(max(labels));
    
    colorList = [];
    for k=1:length(labels)
        colorList = [colorList; colors(labels(k),:)];
    end
    
    
    for k=1:max(labels)
        scatter( score(labels == k , axis1 ) , score(labels == k , axis2 ) , 1 , colors(k,:) , 'filled' );
        hold on
    end
    
               scatter( score( ~secondary_binary_label , axis1) , score( ~secondary_binary_label , axis2) , 30 , colorList( ~secondary_binary_label , : ) , 'filled' , 'o' , 'MarkerEdgeColor', 'w' );
    plot_obj = scatter( score( secondary_binary_label  , axis1) , score( secondary_binary_label  , axis2) , 30 , colorList( secondary_binary_label  , : ) , 'filled' , 'd' , 'MarkerEdgeColor', 'w' );

    hold on
    legend(category_names);


end