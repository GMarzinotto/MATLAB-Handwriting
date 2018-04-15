function [is_valid] = check_if_line_segment_is_valid(Word)

    is_valid = true;
    
    Bitmap = compute_bitmap_from_sequence(Word,'ON_TABLET');

    [y,~]     = find(Bitmap.BoolImage(:,:) == true);
    [~,ncols] = size(Bitmap.BoolImage);
    
    
    meanY = round(mean(y));
    if(Bitmap.BoolImage(meanY,1))
        stroke_counter = 1;
    else
        stroke_counter = 0;
    end
    
    for k = 2:ncols
        %if the previous value was false and new value is true I add +1
        if(~Bitmap.BoolImage(meanY,k-1) && Bitmap.BoolImage(meanY,k))
            stroke_counter = stroke_counter + 1;
        end
    end
    
    if(stroke_counter < 4 )
        is_valid = false;
    end

end