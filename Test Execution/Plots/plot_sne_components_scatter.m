function [ mappedpoints ] = plot_sne_components_scatter(data,labels1,category_names1,labels2,category_names2,labels3,category_names3, secondary_binary_label )
%% plot_sne_components_scatter
%  Plots a scatter using colors that represents each label
%  user my give explicitly the name of each label
%  and also especify which axes from score matrix should be plot
%
% [ _mappedpoints_ ] = _*plot_sne_components_scatter*_ ( _data_ , _labels1_ , _category_names1_ , ... , _labels3_ , _category_names3_ )
%
%%% Inputs
% 
% * *data*  : A matrix containing the features for each data sample
%
% * *labels* : An integer list representing the labels of the points
%              list must start at 1 for the first class and don't skip
%              number
%
% * *category_names* : a cell array what contains the name of each label
%
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if(nargin < 8)
        secondary_binary_label = false(size(labels3));
    end

    if(nargin>3)
        if (nargin>5 && ~isempty(labels3) &&  ~isempty(category_names3) )
            splot = 3;
        else
            splot = 2;
        end
    else
        splot = 1;
    end

    [m_size_persons,n_size_persons] = size(data);
    final_dims=2;
    init_dims_Words=n_size_persons;
    perplexity_Words=20;
    
    
    if( m_size_persons > 3000 ) 
        [~,data,~,~,MidX] = kmedoids(data,3000,'Replicates', 1);
        
        labels1 = labels1(MidX);
        secondary_binary_label = secondary_binary_label(MidX);
        
        if(splot > 1)
            labels2 = labels2(MidX);
        end
        
        if(splot > 2)
            labels3 = labels3(MidX);
        end
        
    end


    mapped_coordinates=tsne(data, [], final_dims, init_dims_Words, perplexity_Words);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%Plot SNE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    mappedpoints.X = mapped_coordinates( : , 1); 
    mappedpoints.Y = mapped_coordinates( : , 2);
    
    for j=1:splot
        
        eval(strcat('jlabels = labels',num2str(j),';'));
        
        colors = distinguishable_colors(max(jlabels));
        colorList = [];
        for k=1:length(jlabels)
            colorList = [colorList; colors(jlabels(k),:)];
        end

        subplot(splot,1,j)
        for k=1:max(jlabels)
            scatter( mapped_coordinates(jlabels == k , 1 ) , mapped_coordinates(jlabels == k , 2 ) , 1 , colors(k,:) , 'filled' );
            hold on
        end

    
        scatter( mapped_coordinates( ~secondary_binary_label , 1) , mapped_coordinates( ~secondary_binary_label , 2) , 20 , colorList( ~secondary_binary_label , :) , 'filled' , 'o' , 'MarkerEdgeColor', 'w' );
        scatter( mapped_coordinates( secondary_binary_label  , 1) , mapped_coordinates( secondary_binary_label  , 2) , 20 , colorList( secondary_binary_label , :)  , 'filled' , 'd' , 'MarkerEdgeColor', 'w' );
        
        hold on
        eval(strcat('legend(category_names',num2str(j),');'))
        xlabel(('1st SNE Component'))
        ylabel(('2nd SNE Component'))
        title('SNE Projections')

    end

   
    
end