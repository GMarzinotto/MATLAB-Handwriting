function [ ] = plot_bitmap_image_with_vertical_histograms( bitmap )

    [ nrows , ncols ] = size( bitmap.BoolImage );

    bool_img_double                     = zeros(nrows , ncols);
    bool_img_double(bitmap.BoolImage)   = 1.0;

    vertical_histograms = 3*floor(sum(bool_img_double,1));
    max_count = max(vertical_histograms);
    
    completed_bitmap_image = false( floor( nrows + max_count + 25) , ncols );
    completed_bitmap_image( 1:nrows , 1:ncols ) =  bitmap.BoolImage;

    for j=1:ncols
        for k=1:vertical_histograms(j)
            completed_bitmap_image( end-k+1 , j ) = true;
        end
    end

    imshow(completed_bitmap_image);

end