function [ energy ] = costfunc_for_feature_selection_mutual_entropy( data , labels )
% Functions are designed to search for local minima


    [nrows , ncols] = size(data);
    
    Max_Relevance  = zeros(1,ncols);
    for j=1:ncols
        Max_Relevance(j)  = mutualinfo( data(:,j) , labels );
    end
    
    Min_Redundance = mean( mean( compute_mutual_information_matrix( data ) ) );


    energy = -1*(mean(Max_Relevance) - Min_Redundance);


end