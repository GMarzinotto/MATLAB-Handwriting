function [ space_size_cm , texts_size_cm , space_start_position_cm , texts_start_position_cm ] = compute_horizontal_box_spacing( Word )

    INCH_TO_CM = 2.54;

    Bitmap = compute_bitmap_from_sequence( Word , 'ON_TABLET' ); 
	
	 bool_image = Bitmap.BoolImage;
    [~,ncols] = size(bool_image);
    
    %Find Colums with no pixel marked
    is_space = false(ncols,1);
    for k=1:ncols
       if(~bool_image(:,k))
           is_space(k) = true;
       end
    end
    
    space_size = [];
    space_start_position = [];
    texts_size = [];
    texts_start_position = [];
    %Count sizes of text blocks and sizes of spaces and their position
    k = 1;
    while(k <= ncols)
        length_block = 1;
        if (k <= ncols) && (is_space(k)) 
            space_start_position = [space_start_position; k];
            k = k+1;
            while (k <= ncols) && (is_space(k)) 
                length_block = length_block + 1;
                k = k+1;
            end
            space_size = [space_size; length_block];
        else
            texts_start_position = [texts_start_position; k];
            k = k+1;
            while (k <= ncols) && (~is_space(k))  
                length_block = length_block + 1;
                k = k+1;
            end
            texts_size = [texts_size; length_block];
        end 
    end
    

    space_size_cm = space_size*INCH_TO_CM/Bitmap.Resolution;
    texts_size_cm = texts_size*INCH_TO_CM/Bitmap.Resolution;
    
    if( ~isempty(space_start_position) )
        space_start_position_cm = ( space_start_position*INCH_TO_CM/Bitmap.Resolution ) + repmat( min(Word.X) , length(space_start_position) , 1 );
    else
        space_start_position_cm = [];
    end
    
    if( ~isempty(texts_start_position) )
        texts_start_position_cm = ( texts_start_position*INCH_TO_CM/Bitmap.Resolution ) + repmat( min(Word.X) , length(texts_start_position) , 1 );
    else
        texts_start_position_cm = [];
    end
    
end