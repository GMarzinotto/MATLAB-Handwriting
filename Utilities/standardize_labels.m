function [ labels_1_to_n , conversion_rule ] = standardize_labels( labels )
    
    %find unique labels on the data
    uniq_sorted_labels = unique(labels);
    
    %Define the conversion rule
    conversion_rule = @(x) find( uniq_sorted_labels == x );

    % Relabel the data
    labels_1_to_n = arrayfun( conversion_rule , labels );

end