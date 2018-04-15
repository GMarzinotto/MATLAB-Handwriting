word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

plot_down = PlotStyle(false,true);


[line_segments] = segment_full_text_by_lines(word);
line = line_segments(3);


figure(),
subplot(3,1,1), plot_pressure(line,plot_down),                      title('Pressure Module PENDOWN')
subplot(3,1,2), plot_pressure_derivative_wrt_time(line,plot_down),  title('Pressure Derivative w.r.t Time PENDOWN')
subplot(3,1,3), plot_pressure_derivative_wrt_xy(line,plot_down),    title('Pressure Derivative w.r.t XY PENDOWN')

