word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

plot_all  = PlotStyle(true,true);
plot_up   = PlotStyle(true,false);
plot_down = PlotStyle(false,true);

[line_segments] = segment_full_text_by_lines(word);
line = line_segments(1);

figure(),
subplot(3,1,1), plot_penup_pendown_segments(line,plot_all),     title('Segments PENDOWN PENUP')
subplot(3,1,2), plot_penup_pendown_segments(line,plot_down),    title('Segments PENDOWN')
subplot(3,1,3), plot_penup_pendown_segments(line,plot_up),      title('Segments PENUP')



figure(),
subplot(3,1,1), plot_strokes_vy_criterion(line,plot_all),       title('Strokes Vy Criterion PENDOWN PENUP')
subplot(3,1,2), plot_strokes_vy_criterion(line,plot_down),      title('Strokes Vy Criterion PENDOWN')
subplot(3,1,3), plot_strokes_vy_criterion(line,plot_up),        title('Strokes Vy Criterion PENUP')



figure(),
subplot(2,1,1), plot_penup_pendown_segments(line,plot_down),    title('Segments PENDOWN')
subplot(2,1,2), plot_strokes_vy_criterion(line,plot_down),      title('Strokes Vy Criterion PENDOWN')

