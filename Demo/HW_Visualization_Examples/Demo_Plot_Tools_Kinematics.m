word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

plot_all  = PlotStyle(true,true);
plot_up   = PlotStyle(true,false);
plot_down = PlotStyle(false,true);


[line_segments] = segment_full_text_by_lines(word);
line = line_segments(3);

MAX_SPEED = 10;    %Optional to ensure same axis through different files
MAX_ACELL = 200;   %Optional to ensure same axis through different files
MAX_JERK  = 50000; %Optional to ensure same axis through different files

figure(),
subplot(3,1,1), plot_speed_module(line,plot_all, MAX_SPEED),  title('Speed Module PENDOWN PENUP')
subplot(3,1,2), plot_speed_module(line,plot_down,MAX_SPEED),  title('Speed Module PENDOWN')
subplot(3,1,3), plot_speed_module(line,plot_up),              title('Speed Module PENUP')


figure(),
subplot(2,1,1), plot_speed_x(line,plot_down,MAX_SPEED),      title('Speed X PENDOWN')
subplot(2,1,2), plot_speed_y(line,plot_down,MAX_SPEED),      title('Speed Y PENDOWN')


figure(),
subplot(3,1,1), plot_speed_module(line,plot_down, MAX_SPEED), title('Speed Module PENDOWN')
subplot(3,1,2), plot_acceleration_module(line,plot_down, MAX_ACELL),     title('Acceleration Module PENDOWN')
subplot(3,1,3), plot_jerk_module(line,plot_down,MAX_JERK),             title('Jerk Module PENDOWN')

