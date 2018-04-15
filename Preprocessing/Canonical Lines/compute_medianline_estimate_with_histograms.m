function [ meadian_line_height ] = compute_medianline_estimate_with_histograms( Word  )
     

    Word   = discard_penup_tracking_information( Word );
    bitmap = compute_bitmap_from_sequence( Word , 'ON_TABLET' );
    bool_img = bitmap.BoolImage;

    bitmap_derivative.BoolImage = xor( bool_img(:,1:end-1) , bool_img(:,2:end) );
    
    %figure(), plot_bitmap_image_with_horizontal_histograms(bitmap_derivative);
    
    bool_img_double                              = zeros( size( bitmap_derivative.BoolImage ) );
    bool_img_double(bitmap_derivative.BoolImage) = 1.0;
    horizontal_histograms = floor(sum(bool_img_double,2));
    
       
    offset_y    = min(Word.Y);
    pixel_width = 2.54/bitmap.Resolution;
     
    %Find Median Line
    closest_to_meadian = find( horizontal_histograms == max(horizontal_histograms) );
    closest_to_meadian = closest_to_meadian(1);

    %Convert Median Line to Online Heigh
    meadian_line_height = offset_y + pixel_width*(closest_to_meadian);    
 

end