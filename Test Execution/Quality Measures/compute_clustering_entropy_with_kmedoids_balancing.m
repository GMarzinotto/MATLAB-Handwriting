function [ Entropy_Struct ] = compute_clustering_entropy_with_kmedoids_balancing( cluster_indexes , labels , nb_clusters )


    %Check if all the categories have the same number of elements
    for k=2:max(labels)
        if( length(find(labels==1)) ~=  length(find(labels==k)) )
            error('Cannot compute entropy on an umbalanced dataset')
        end
    end



    %Entropy at Clustering
    for k=1:nb_clusters
        labels_k            = labels( cluster_indexes == k );
        size_clusters(k)    = length(labels_k)/length(labels);
        for i=1:max(labels) 
            LabelEntropyAtEachCluster(i,k) = -1*(length(find(labels_k == i))/length(labels_k))*log2((length(find(labels_k == i))/length(labels_k)));
        end
    end


    LabelEntropyAtEachCluster( isnan( LabelEntropyAtEachCluster ) ) = 0;

    entropy_label_wrt_cluster = sum(LabelEntropyAtEachCluster);
    weighted_label_entropy_wrt_cluster = (entropy_label_wrt_cluster*size_clusters');


    %Entropy at Labels
    for i=1:max(labels)
        labels_i        = cluster_indexes( labels == i );
        size_class(i)  = length(labels_i)/length(labels);
        for k=1:nb_clusters
            ClusterEntropyAtEachLabel(k,i) = -1*(length(find(labels_i==k))/length(labels_i))*log2((length(find(labels_i==k))/length(labels_i)));
        end
    end


    ClusterEntropyAtEachLabel( isnan( ClusterEntropyAtEachLabel ) ) =  0;
    entropy_cluster_wrt_labels        = sum(ClusterEntropyAtEachLabel);
    total_cluster_entropy_wrt_labels  = mean(entropy_cluster_wrt_labels);

    weighted_label_entropy_wrt_cluster  = weighted_label_entropy_wrt_cluster/log2(max(labels));
    entropy_label_wrt_cluster           = entropy_label_wrt_cluster/log2(max(labels));
    total_cluster_entropy_wrt_labels    = total_cluster_entropy_wrt_labels/log2( nb_clusters );
    entropy_cluster_wrt_labels          = entropy_cluster_wrt_labels/log2( nb_clusters );

    Entropy_Struct = struct('Total_Entropy_Label_wrt_Cluster',weighted_label_entropy_wrt_cluster,...
                           'Entropy_Label_wrt_Cluster',entropy_label_wrt_cluster,...
                           'Total_Entropy_Cluster_wrt_Label',total_cluster_entropy_wrt_labels,...
                           'Entropy_Cluster_wrt_Label',entropy_cluster_wrt_labels);



end