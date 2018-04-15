word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

plot_down = PlotStyle(false,true);

[line_segments] = segment_full_text_by_lines(word);
line = line_segments(3);

figure(),
plot_diacritic_mark_strokes_detection(line,plot_down),  title('Diacritic Mark Detection')

figure(),
plot_diacritic_mark_strokes_classification(line,plot_down),  title('Diacritic Mark Classification')

