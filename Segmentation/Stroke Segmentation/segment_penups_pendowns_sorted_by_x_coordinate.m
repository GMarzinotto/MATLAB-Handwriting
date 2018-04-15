function [ all_segments_sort , penup_segments_sort , pendown_segments_sort , separators_sort ] = segment_penups_pendowns_sorted_by_x_coordinate( Word )

    [ all_segments , penup_segments , pendown_segments , separators ] = segment_by_penups_pendowns( Word );
    
    % Sort all Segments
    n_segments = length(all_segments);
    all_segments_x_median = zeros(1,n_segments);
    for k=1:n_segments
         all_segments_x_median(k) = median(all_segments(k).X);
    end
    [ ~ , IDX ] = sort(all_segments_x_median);
    all_segments_sort = all_segments(IDX);
    separators_sort   = separators(IDX);
    
    
    % Sort Penup Segments
    n_segments = length(penup_segments);
    penup_segments_x_median = zeros(1,n_segments);
    for k=1:n_segments
         penup_segments_x_median(k) = median(penup_segments(k).X);
    end
    [ ~ , IDX ] = sort(penup_segments_x_median);
    penup_segments_sort = penup_segments(IDX);

    
    % Sort Pendown Segments
    n_segments = length(pendown_segments);
    pendown_segments_x_median = zeros(1,n_segments);
    for k=1:n_segments
         pendown_segments_x_median(k) = median(pendown_segments(k).X);
    end
    [ ~ , IDX ] = sort(pendown_segments_x_median);
    pendown_segments_sort = pendown_segments(IDX);    
    

end