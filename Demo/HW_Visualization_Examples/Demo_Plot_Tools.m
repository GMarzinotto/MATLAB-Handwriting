word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

plot_all  = PlotStyle(true,true);
plot_up   = PlotStyle(true,false);
plot_down = PlotStyle(false,true);

figure(),
subplot(1,3,1), plot_in_black_and_white(word,plot_all),   title('Position PENDOWN PENUP')
subplot(1,3,2), plot_in_black_and_white(word,plot_down),  title('Position PENDOWN')
subplot(1,3,3), plot_in_black_and_white(word,plot_up),    title('Position PENUP')




[line_segments] = segment_full_text_by_lines(word);
line = line_segments(3);

figure(),
subplot(3,1,1), plot_in_black_and_white(line,plot_all),   title('Position PENDOWN PENUP')
subplot(3,1,2), plot_in_black_and_white(line,plot_down),  title('Position PENDOWN')
subplot(3,1,3), plot_in_black_and_white(line,plot_up),    title('Position PENUP')
