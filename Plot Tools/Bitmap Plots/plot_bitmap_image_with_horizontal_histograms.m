function [ ] = plot_bitmap_image_with_horizontal_histograms( bitmap )

    [ nrows , ncols ] = size( bitmap.BoolImage );

    bool_img_double                     = zeros(nrows , ncols);
    bool_img_double(bitmap.BoolImage)   = 1.0;

    horizontal_histograms = floor(sum(bool_img_double,2));
    max_count = max(horizontal_histograms);
    
    completed_bitmap_image = false( nrows , floor(ncols + max_count + 50) );
    completed_bitmap_image( 1:nrows , 1:ncols ) =  bitmap.BoolImage;

    for j=1:nrows
        for k=1:horizontal_histograms(j)
            completed_bitmap_image( j , end-k+1 ) = true;
        end
    end

    imshow(completed_bitmap_image);
        
end