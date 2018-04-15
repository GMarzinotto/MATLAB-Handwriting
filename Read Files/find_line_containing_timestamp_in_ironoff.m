function [ lines_index ] = find_line_containing_timestamp_in_ironoff( filepath , timestamps )

    n_timestamps = length(timestamps);
    lines_index = [];
    
    timestamps = sort(timestamps);
    
    j_search_start_idx = 1;
        
    for k=1:n_timestamps
        
        fid = fopen( filepath , 'rt');
        s = textscan(fid, '%s', 'delimiter', '\n');
        fclose(fid);
        
        % search for your Region:
        for j = j_search_start_idx:length(s{1})
            line_matches = strfind(s{1}{j}, num2str(timestamps(k)) );
            if(~isempty( line_matches ))
                line_matches = str2num(s{1}{j});
                % end is the column where the time component is stored...
                if( ~isempty(line_matches) && line_matches(end) == timestamps(k) )
                    lines_index = [lines_index; j];
                    j_search_start_idx = j;
                    break;
                end
            end
        end
    end

        lines_index = unique(lines_index);

    
end