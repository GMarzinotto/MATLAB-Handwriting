function [] = plot_linear_discriminant_analysis_scatter( data , labels ,category_names , axis1 , axis2 )
%% plot_linear_discriminant_analysis_scatter
%  Plots a scatter using linear discriminant analysis as dimentionality
%  reduction technique, colors in the scatter represents each label
%  user my give explicitly the name of each label
%  and also especify which axes from score matrix should be plot
%
% [ ] = _*plot_linear_discriminant_analysis_scatter*_ ( _data_ , _labels_ , _category_names_ , _axis1_ , _axis2_ )
%
%%% Inputs
% 
% * *data*  : A matrix containing the features for each data sample
%
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


    [ ~ , score , eigenvalues ] = compute_linear_discriminant_analysis( data , labels );
    generic_scatter_data_plot( score , labels , category_names , axis1 , axis2 )
    
    explained = 100*(eigenvalues(axis1) + eigenvalues(axis2))/sum(eigenvalues);
    
    xlabel(strcat(num2str(axis1),'º LDA Principal Component'))
    ylabel(strcat(num2str(axis2),'º LDA Principal Component'))
    title(strcat('LDA inertia: ',num2str(explained),'%'))

end