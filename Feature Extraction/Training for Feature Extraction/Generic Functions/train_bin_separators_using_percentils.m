function [ bin_separators ] = train_bin_separators_using_percentils( unidimentional_data , number_of_bins )
%% train_bin_separators_using_percentils
%  Computes bins delimiters with percentil methods using the unidimentional_data provided
%  This function may be used to train bins for speed, acceleration, jerk, etc etc etc...
%
% [ _bin_separators_ ] = _*train_bin_separators_using_percentils*_ ( _unidimentional_data_ , _number_of_bins_ )
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
    
    bin_separators = prctile( unidimentional_data , [(100/number_of_bins):(100/number_of_bins):(100 - (100/number_of_bins))] );
 
end