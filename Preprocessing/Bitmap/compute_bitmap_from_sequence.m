function [ Bitmap ] = compute_bitmap_from_sequence(Word,word_type)
%% compute_bitmap_from_sequence
%  Creates a binary image from a Word Struct containing a sequence of
%  points, type can be provided to enable/disable track on air
%
% [ _newWord_ ] = _*compute_bitmap_from_sequence*_ ( _Word_ , _word_type_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
%%% Outputs
% 
% * *Bitmap*  : A Bitmap Struct containing the bipmap image, the resolution
%               and the coordinates X Y of the points from the original
%               sequence, converte to pixels of the bitmap
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    images_resolution_dpi = 300;
    inches_to_cm   = 2.54;
    
    resolution_factor = images_resolution_dpi/inches_to_cm;

    %Convert to a new tracking word type 'ON_TABLET' , 'ON_AIR' or both
    word_map   = convert_word_to_a_new_tracking_type(Word,word_type);
    
    
    %Discretize everything using the resolution factor and move to (0,0)
    word_map.X = round((word_map.X - min(word_map.X))*resolution_factor) + 1;
    word_map.Y = round((-1*word_map.Y - min(-1*word_map.Y))*resolution_factor) + 1;


    numCols = max(word_map.X);
    numRows = max(word_map.Y);

    bool_image = false(numRows, numCols);

    for k=1:word_map.NumSamples-1
        %If it is not a lost of the track, then we interpolate
        if( ~any(k == word_map.LostOfTrackPoints) )
            %Find the direction with wider movement
            dX = word_map.X(k+1) - word_map.X(k);
            dY = word_map.Y(k+1) - word_map.Y(k); 
            %Check if there was a displacement
            if( dX~=0 || dY~=0 )
                if(abs(dX) > abs(dY))
                    slope     = (dY/dX);
                    init_x = word_map.X(k);
                    init_y = word_map.Y(k);
                    iterator  = [word_map.X(k):sign(dX):word_map.X(k+1)];
                    for j=iterator         
                        bool_image( round(slope*(j-init_x)) + init_y, j ) = true; 
                    end
                else
                    slope = (dX/dY);
                    init_x = word_map.X(k);
                    init_y = word_map.Y(k);
                    iterator = [word_map.Y(k):sign(dY):word_map.Y(k+1)];
                    for j=iterator
                        bool_image( j , round(slope*(j-init_y)) + init_x ) = true;
                    end
                end
            else
                bool_image(  word_map.Y(k) ,  word_map.X(k) ) = true; 
            end
        end
    end


    Bitmap.Coords.X = word_map.X;
    Bitmap.Coords.Y = word_map.Y;
    Bitmap.BoolImage  = bool_image; 
    Bitmap.Resolution = images_resolution_dpi;

end