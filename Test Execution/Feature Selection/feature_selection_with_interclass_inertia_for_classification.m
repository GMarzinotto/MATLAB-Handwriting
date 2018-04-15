function [ inmodel , history ] = feature_selection_with_interclass_inertia_for_classification( data , labels , nb_features )

    [nrow , ncols] = size(data);
    
    if (nargin < 3)
       nb_features = ncols;
    end
    
    labels = standardize_labels(labels);
    n_labels = length(unique(labels));
    
    if( n_labels < 2 )
        error('you must provide at least 2 labels to perform feature selection for classification')
    else 
        fun = @(X,Y,Xcv,Ycv) ( costfunc_for_feature_selection_interclass_inertias(X,Y) );
    end
    
       
    opts = statset('display','iter');
    [ inmodel , history ] = sequentialfs(fun,data,labels,'nfeatures',nb_features,'options',opts);

end