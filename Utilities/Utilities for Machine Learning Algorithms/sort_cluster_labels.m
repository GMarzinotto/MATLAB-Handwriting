function [ new_clust_labels , new_clust_centers ] = sort_cluster_labels( data , clustering_labels , cluster_centers )
%% sort_cluster_labels
%  When we apply clustering, the labels of each cluster are atributed
%  randomly. This can be annoying when repeating a clustering experience
%  several times and comparing the results. This function sorts the cluster
%  labels in a meaningful and fixed way, Sorting them using the first
%  principal component. Cluster 1 will be the leftmost cluster on the first
%  principal component and the cluster labels will increase as we move to
%  the right along that principal component.
%                       
%
% [ _new_clust_labels_ , _new_clust_centers_ ] = _*sort_cluster_labels*_ ( _data_ , _clustering_labels_ , _cluster_centers_ )
%
%%% Inputs
% 
% * *data* 	: A matrix of data where the rows are the observations and the
%             columns are the features
%
% * *clustering_labels* : Clustering Labels for each data point 
%                         to be sorted
%
% * *cluster_centers*   : Cluster Centers to be Sorted
%                      
%
%%% Outputs
%
% * *new_clust_labels*  : The new clustering labels after renaming the
%                         clusters using a fixed convention
%
% * *new_clust_centers* : The new clustering centers after renaming the
%                         clusters using a fixed convention
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%

 % Compute the principal components
 pca_vectors = pca(data);
 
 % Project cluster centers into the PCA
 clust_center_pca = (cluster_centers*pca_vectors);

 % Find the new indexes for each cluster
 [ ~ , index ] = sortrows(clust_center_pca);
 
 % Sort the cluster centers
 new_clust_centers = cluster_centers(index,:);
 
 % Relabel the data
 new_clust_labels = arrayfun(@(x) find( index == x ) , clustering_labels );
 
end