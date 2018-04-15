word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON3\Test1.txt');


plot_down = PlotStyle(false,true);


[line_segments] = segment_full_text_by_lines(word);

nsegments  = length(line_segments);
first_line = line_segments(1);


figure(),
subplot(3,1,1), plot_canonical_lines_estimated_with_local_min_max( first_line , 0 , true , plot_down ),   title('Canonical Lines, Polynomial Order 0')
subplot(3,1,2), plot_canonical_lines_estimated_with_local_min_max( first_line , 1 , true , plot_down ),   title('Canonical Lines, Polynomial Order 1')
subplot(3,1,3), plot_canonical_lines_estimated_with_local_min_max( first_line , 2 , true , plot_down ),   title('Canonical Lines, Polynomial Order 2')

