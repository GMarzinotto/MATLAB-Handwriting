function [ local_minima , local_maxima ] = compute_local_minima_and_local_maxima( Word , word_type )
%% compute_local_minima_and_local_maxima
%  Computes all the local minima and local maxima from the Word Struct.
%  Local minimas and maximas are computed as points of the sequence where
%  the speed value changes sign. Positive => Negative implies local maxima
%  Negative => Positive implies local minima.
%
% [ _local_minima_ , _local_maxima_ ] = _*compute_local_minima_and_local_maxima*_ ( _Word_ , word_type )
%
%%% Inputs
% 
% * *Word*          : A Word Struct as defined in this framework 
%                     see wordStruct documentation.  
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
%%% Inputs
%
% * *local_minima*  : An array containing the coordinates of the local
%                     minimas
%
% * *local_maxima*  : An array containing the coordinates of the local
%                     maximas
%
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%



    [ all_segments_penup_pendown , segments_penup , segments_pendown ] = segment_by_penups_pendowns(Word);
    
    local_minima.X = [];
    local_minima.Y = [];

    local_maxima.X = [];
    local_maxima.Y = [];

    
    if(strcmp(word_type,'ON_TABLET'))
        my_segments = segments_pendown;
    else if(strcmp(word_type,'ON_AIR'))
            my_segments = segments_penup;
        else if(strcmp(word_type,'ON_TABLET_ON_AIR'))
                my_segments = all_segments_penup_pendown;
            end
        end
    end
    
    for k=1:length(my_segments)
        
        ksegment = my_segments(k);
        [ ~, ~, vy ] = compute_all_speeds(ksegment);
        j = 1;

        while (j < length(vy)-1)


            if(vy(j)>=0)
                startSign   =  1;
            else 
                startSign   = -1;
            end
            
            while(j < length(vy)-1 && ( (sign(vy(j+1)) >= 0 && startSign   ==  1) || (sign(vy(j+1)) <= 0 && startSign   ==  -1) ))
                j         = j+1;
            end

            
            if( j < length(vy)-1 )
                if(startSign   ==  1)
                    local_maxima.X = [local_maxima.X; ksegment.X(j)];
                    local_maxima.Y = [local_maxima.Y; ksegment.Y(j)];
                    %local_maxima.P = [local_maxima.P; Word.P(end_global)];
                else
                    local_minima.X = [local_minima.X; ksegment.X(j)];
                    local_minima.Y = [local_minima.Y; ksegment.Y(j)];
                    
                end
            end

            j = j + 1;
            
        end
        
    end
    
    %[ local_minima , local_maxima ] = filter_local_minima_and_local_maxima( Word , local_minima , local_maxima );
   
   
end