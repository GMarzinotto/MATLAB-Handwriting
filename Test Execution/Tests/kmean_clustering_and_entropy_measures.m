function [ Entropy_Struct , cluster_indexes , cluster_centers ] = kmean_clustering_and_entropy_measures( data , labels , nb_clust , label_names , features_names )

    [ cluster_indexes , cluster_centers ] = kmeans(data,nb_clust,'display','iter', 'replicates', 20 );
    [ cluster_indexes , cluster_centers ] = sort_cluster_labels( data , cluster_indexes , cluster_centers );
    
    labels = standardize_labels( labels );   
    for k=1:max(labels)
        size_label(k) = length(find(labels == k));
    end
    
    smallest_class = min(size_label);
    num_clases     = max(labels);
    
%     retained_examples_cluster_indexes = [];
%     retained_examples_labels = [];
%     for k=1:num_clases
%         class_indexes = find(labels == k);
%         [~,~,~,~,MidX] = kmedoids(data(class_indexes),smallest_class,'Replicates', 1);
%         retained_examples_cluster_indexes = [retained_examples_cluster_indexes;  cluster_indexes(class_indexes(MidX)) ];
%         retained_examples_labels = [retained_examples_labels;  labels(class_indexes(MidX)) ];
%     end
% 
%     [ Entropy_Struct1 ]   = compute_clustering_entropy_with_kmedoids_balancing( retained_examples_cluster_indexes , retained_examples_labels , nb_clust );
    [ Entropy_Struct ]   = compute_clustering_entropy_with_label_scaling( cluster_indexes , labels , nb_clust );
    
    for k=1:nb_clust
       category_names{k} = strcat('Cluster ',num2str(k)) ;
    end
    
        
    figure(),
    plot_principal_components_scatter(data,labels,label_names,1,2);
    
    figure(),
    plot_principal_components_scatter(data,cluster_indexes ,category_names,1,2);
    
    figure(),
    subplot(2,1,1), plot_principal_components_scatter(data,labels,label_names,1,2);
    subplot(2,1,2), plot_principal_components_scatter(data,cluster_indexes ,category_names,1,2);
     
    
    
    %% Plot Bar Diagrams 
    figure(),
    n_perc_plot_rows = 3;
    n_perc_plot_cols = ceil(nb_clust/n_perc_plot_rows);
    colors = distinguishable_colors(nb_clust);
    
    %if more rows than columns, then we swap them 
    if( n_perc_plot_cols < n_perc_plot_rows )
        aux_val = n_perc_plot_cols;
        n_perc_plot_cols = n_perc_plot_rows;
        n_perc_plot_rows = aux_val;
    end
    
    for k=1:nb_clust
        aux = labels(cluster_indexes == k);
        bar_content = [];
        for j=1:num_clases
            bar_content = [ bar_content  ( (length(labels)*sum(aux == j ))/(sum(labels == j)*length(aux)) + 0.01) ];
        end
        subplot( n_perc_plot_rows , n_perc_plot_cols , k),
        bar(bar_content,'FaceColor', colors(k,:) );
        axis([0 (num_clases+1) 0 3 ])
        h = text([1:num_clases],0.1*ones(1,num_clases),label_names,'VerticalAlignment','middle','FontWeight','bold');
        set(h, 'rotation', 90)
        title(strcat('Cluster ',num2str(k),' NSamples = ',num2str(length(aux))))
    end
    
    
    %% Plot Cluster Centers
    figure(),
    n_feat_plot_rows = 3;
    n_feat_plot_cols = ceil(nb_clust/n_feat_plot_rows);
    
    %if more rows than columns, then we swap them 
    if( n_feat_plot_cols < n_feat_plot_rows )
        aux_val = n_feat_plot_cols;
        n_feat_plot_cols = n_feat_plot_rows;
        n_feat_plot_rows = aux_val;
    end

    for k=1:nb_clust
        subplot(n_feat_plot_rows , n_feat_plot_cols , k), plot_model_feature_coefficients_with_2_classes( cluster_centers(k ,:) , features_names )
        title(strcat('Cluster ',num2str(k),' NSamples = ',num2str(length(aux))))
    end

    
end