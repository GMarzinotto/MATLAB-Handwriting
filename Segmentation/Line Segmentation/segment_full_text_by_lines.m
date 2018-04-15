function [line_segments] = segment_full_text_by_lines(Word)
%% segment_full_text_by_lines
%  Takes Word and returns a list of Word Structs, where each element
%  contains a line from the text that was isolated by a very large  
%  penup space. 
%
% [ _line_segments_ ] = _*segment_full_text_by_lines*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*    : A Word Struct as defined in this framework 
%               see wordStruct documentation. 
%
% * *numSegments* : Number of segments to be produce in the output.
%
%%% Outputs
% 
% * *line_segments* : A list of Word Structs as defined in this framework 
%                     where each element should contain an unique 
%                     line of text.
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    %Pre Segment in Penups and Pendowns
    [all_segments, ~ , ~ , separators] = segment_by_penups_pendowns(Word);
    
    %Mark the Pendown Segments
    n_segments = length(all_segments);
    is_pendown = [];
    
    for k=1:n_segments
        if(strcmp(all_segments(k).Tracking,'ON_TABLET'))
            is_pendown = [is_pendown; k];
        end
    end
    
    line_delimiters = [];
    start_stroke = is_pendown(1);
    dist_maxes = [];
    
    %Loop through the Pendown Segments
    for k = 1:length(is_pendown)-1
        
        iElem = is_pendown(k);
        next_elem = is_pendown(k+1);
        
        ditance_x     = all_segments(next_elem).X(1) - all_segments(iElem).X(end);
        ditance_x_abs = abs(ditance_x);
        ditance_y     = all_segments(next_elem).Y(1) - all_segments(iElem).Y(end);
        ditance_y_abs = abs(ditance_y);
        
        dist_maxes = [dist_maxes;  max(ditance_x_abs,ditance_y_abs)];
        
        %Find a retour in the X axis or the Y axis is larger than 6cm and mark as a new line
        if( max(ditance_x_abs,ditance_y_abs) > 6 || ( ditance_x < -2  && ditance_y < -0.25 ) )
            end_stroke = iElem;
            line_delimiters = [line_delimiters; [separators(start_stroke,1)  separators(end_stroke,2)]];
            start_stroke = next_elem;
        end
    end
    
    %Add the last line delimiter
    line_delimiters = [line_delimiters; [separators(start_stroke,1)  separators(end,2)]];
    [ num_del , ~ ] = size(line_delimiters);
    
    line_segments = [];
    for k=1:num_del
        ksegment = segment_using_separators( Word , line_delimiters(k,1) , line_delimiters(k,2) );
        line_segments = [ line_segments; ksegment ];
    end
    
    %Verify is line is long enough
    valid_line = false(0);
    for k=1:length(line_segments)
        valid_line = [ valid_line; is_line_large_enough( line_segments(k) ) ];
    end
    
    %delete unvalid line segments
    line_segments(~valid_line) = [];
    
    %Tag all the word objects as Lines
    for k=1:length(line_segments)
       line_segments(k).ContentType = 'LINE';    
    end
    
end