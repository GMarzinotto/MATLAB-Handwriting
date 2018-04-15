word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

plot_all  = PlotStyle(true,true);
plot_up   = PlotStyle(true,false);
plot_down = PlotStyle(false,true);

[line_segments] = segment_full_text_by_lines(word);
line = line_segments(3);


figure(),
subplot(3,1,1), plot_delayed_strokes(line,plot_all),   title('Position PENDOWN PENUP')
subplot(3,1,2), plot_delayed_strokes(line,plot_down),  title('Position PENDOWN')
subplot(3,1,3), plot_delayed_strokes(line,plot_up),    title('Position PENUP')

figure(),
subplot(3,1,1), plot_delayed_strokes(line,plot_all),   title('Position PENDOWN PENUP')
subplot(3,1,2), plot_delayed_strokes(line,plot_down),  title('Position PENDOWN')
subplot(3,1,3), plot_delayed_strokes(line,plot_up),    title('Position PENUP')

