function [ ] = plot_bitmap_image( bitmap )

    [ nrows , ncols ] = size( bitmap.BoolImage );

    bool_img_double                     = zeros(nrows , ncols);
    bool_img_double(bitmap.BoolImage)   = 1.0;

    imshow(bool_img_double);
    
end

