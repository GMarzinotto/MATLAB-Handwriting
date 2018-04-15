function [ local_minima , local_maxima ] = filter_local_minima_and_local_maxima( Word , local_minima , local_maxima )


     
    %Filter Local Minima and Maxima. Remove pairs (local_min,local_max)
    %whenever they are close up to a certain constant (2mm)
    n_local_min = length(local_minima.X);
    n_local_max = length(local_maxima.X);
    
    bad_local_maxima = [];
    bad_local_minima = [];
    for j=1:n_local_max
        for k=1:n_local_min
            if( sqrt( power(local_maxima.X(j) - local_minima.X(k) , 2) + power(local_maxima.Y(j) - local_minima.Y(k) , 2) ) < 0.2 )
                bad_local_maxima = [bad_local_maxima; j];
                bad_local_minima = [bad_local_minima; k];
            end
        end
    end
    
    bad_local_maxima = unique(bad_local_maxima);
    bad_local_minima = unique(bad_local_minima);
    
    if( n_local_max - length(bad_local_maxima) >= 1 )
        local_maxima.X(bad_local_maxima) = [];
        local_maxima.Y(bad_local_maxima) = [];
    end
    if( n_local_min - length(bad_local_minima) >= 1 )
        local_minima.X(bad_local_minima) = [];
        local_minima.Y(bad_local_minima) = [];
    end
    
%     %%Filter using the medianline base estimate
%     medianline = compute_medianline_estimate_with_histograms( Word );
%     [ ~ , vertical_length ] = compute_word_horizontal_and_vertical_lengths( Word );
%     
%     lower_bound = medianline - (vertical_length)*0.15;
%     upper_bound = medianline + (vertical_length)*0.15;
%     
%     %%Filter Local Minima way above the simple median line
%     n_local_min = length(local_minima.X);
%     bad_local_minima = find(local_minima.Y > upper_bound);
%     
%     if( n_local_min - length(bad_local_minima) >= 1 )
%         local_minima.X(bad_local_minima) = [];
%         local_minima.Y(bad_local_minima) = [];
%     end
%     
%     %%Filter Local Maxima way above the simple median line
%     n_local_max = length(local_maxima.X);
%     bad_local_maxima = find(local_maxima.Y < lower_bound);
%     
%     if( n_local_max - length(bad_local_maxima) >= 1 )
%         local_maxima.X(bad_local_maxima) = [];
%         local_maxima.Y(bad_local_maxima) = [];
%     end
    
    %%Filter Local Maxima too close to each other
    n_local_max = length(local_maxima.X);
    
    bad_local_maxima = [];
    for j=1:n_local_max
        for k=(j+1):n_local_max
            if( sqrt( power(local_maxima.X(j) - local_maxima.X(k) , 2) + power(local_maxima.Y(j) - local_maxima.Y(k) , 2) ) < 0.05  )
                bad_local_maxima = [bad_local_maxima; j];
            end
        end
    end
    
    bad_local_maxima = unique(bad_local_maxima);
    if( n_local_max - length(bad_local_maxima) >= 1 )
        local_maxima.X(bad_local_maxima) = [];
        local_maxima.Y(bad_local_maxima) = [];
    end
    
    
    %%Filter Local Minima too close to each other
    n_local_min = length(local_minima.X);
    
    bad_local_minima = [];
    for j=1:n_local_min
        for k=(j+1):n_local_min
            if( sqrt( power(local_minima.X(j) - local_minima.X(k) , 2) + power(local_minima.Y(j) - local_minima.Y(k) , 2) ) < 0.05  )
                bad_local_minima = [bad_local_minima; j];
            end
        end
    end
    
    bad_local_minima = unique(bad_local_minima);
    
    if( n_local_min - length(bad_local_minima) >= 1 )
        local_minima.X(bad_local_minima) = [];
        local_minima.Y(bad_local_minima) = [];
    end
    
end