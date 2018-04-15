word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

Bitmap = compute_bitmap_from_sequence(word,'ON_TABLET');


figure(),
plot_bitmap_image( Bitmap ),   title('Bitmap')


figure(),
plot_bitmap_image_with_horizontal_histograms( Bitmap ),   title('Bitmap with horizontal histograms')


[line_segments] = segment_full_text_by_lines(word);
Bitmap_Line = compute_bitmap_from_sequence( line_segments(1) ,'ON_TABLET');


figure(),
plot_bitmap_image_with_vertical_histograms( Bitmap_Line ),     title('Bitmap with vertical histograms')
