word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');


[line_segments] = segment_full_text_by_lines(word);
line = line_segments(3);


figure(),
subplot(2,1,1), plot_medianline_spaces( line ), title('Spaces Computation using medianline')
subplot(2,1,2), plot_convexhull_spaces( line ), title('Spaces Computation using convex forms')