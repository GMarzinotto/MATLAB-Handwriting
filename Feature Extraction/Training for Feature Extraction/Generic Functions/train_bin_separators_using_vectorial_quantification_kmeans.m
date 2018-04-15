function [ bin_separators ] = train_bin_separators_using_vectorial_quantification_kmeans( unidimentional_data , number_of_bins )
%% train_bin_separators_uniformely
%  Computes bins delimiters with kmeans vectorial quantification methods using the unidimentional_data 
%  provided. This function may be used to train bins for speed, acceleration, jerk, etc etc etc...
%
% [ _bin_separators_ ] = _*train_bin_separators_uniformely*_ ( _unidimentional_data_ , _number_of_bins_ )
%
%%% Inputs
% 
% * *unidimentional_data* : An unidimentional vector of the feature to compute the bin separators
%
% * *number_of_bins*      : Number of bins to make the estimation
%
%%% Outputs
% 
% * *bin_separators*  : An array containing the L2 norm of (comp_x,comp_y)
%
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    [nrows,ncols] = size(unidimentional_data);
    
    if( nrows ~= 1 && ncols ~= 1 )
        error('invalid input data size, must be unidimensional or have more examples')
    end
    
    cluster_indexes = kmeans( unidimentional_data , number_of_bins );
 
    delimiters = [];
    for k=1:number_of_bins
       min_val = min(unidimentional_data( cluster_indexes == k )); 
       max_val = max(unidimentional_data( cluster_indexes == k ));
       delimiters = [ delimiters min_val max_val ];
    end
    
    [ sorted_delimiters ] = sort(delimiters);
    
    bin_separators = zeros( 1 , number_of_bins - 1 );
    idx = 1;
    for k=2:2:length(sorted_delimiters)-2
        bin_separators(idx) = (sorted_delimiters(k) + sorted_delimiters(k+1))/2.0;
        idx = idx + 1;
    end
    
    
end