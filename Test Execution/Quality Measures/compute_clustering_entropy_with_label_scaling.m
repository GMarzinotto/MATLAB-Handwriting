function [ Entropy_Struct ] = compute_clustering_entropy_with_label_scaling( cluster_indexes , labels , nb_clusters )

    %nb_clusters = max(cluster_indexes);

    %Entropy at Clustering
    for k=1:nb_clusters
        labels_k            = labels( cluster_indexes == k );
        size_clusters(k)    = length(labels_k)/length(labels);
        %compute scores for unbalanced database
        for i=1:max(labels)
            aux_score(i) = length(find(labels_k == i))/length(find(labels == i));
        end
        sum_aux_score = sum(aux_score);
        for i=1:max(labels) 
            LabelEntropyAtEachCluster(i,k) = -1*(aux_score(i)/sum_aux_score)*log2(aux_score(i)/sum_aux_score);
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
    total_cluster_entropy_wrt_labels  = sum(size_class*entropy_cluster_wrt_labels');

    weighted_label_entropy_wrt_cluster  = weighted_label_entropy_wrt_cluster/log2(max(labels));
    entropy_label_wrt_cluster           = entropy_label_wrt_cluster/log2(max(labels));
    total_cluster_entropy_wrt_labels    = total_cluster_entropy_wrt_labels/log2( nb_clusters );
    entropy_cluster_wrt_labels          = entropy_cluster_wrt_labels/log2( nb_clusters );

    Entropy_Struct = struct('Total_Entropy_Label_wrt_Cluster',weighted_label_entropy_wrt_cluster,...
                           'Entropy_Label_wrt_Cluster',entropy_label_wrt_cluster,...
                           'Total_Entropy_Cluster_wrt_Label',total_cluster_entropy_wrt_labels,...
                           'Entropy_Cluster_wrt_Label',entropy_cluster_wrt_labels);



end