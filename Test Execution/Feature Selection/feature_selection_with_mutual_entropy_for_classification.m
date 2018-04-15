function [ inmodel , history ] = feature_selection_with_mutual_entropy_for_classification( data , labels , nb_features )


    [nrow , ncols] = size(data);
    
    if (nargin < 3)
       nb_features = ncols;
    end
    
    labels = standardize_labels(labels);
    n_labels = length(unique(labels));
    

    fun = @(X,Y,Xcv,Ycv) (costfunc_for_feature_selection_mutual_entropy(X,Y));
       
    opts = statset('display','iter');
    [ inmodel , history ] = sequentialfs(fun,data,labels,'nfeatures',nb_features,'options',opts);

end