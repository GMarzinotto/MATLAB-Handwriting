[ word ] = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

plot_all  = PlotStyle(true,true);
plot_up   = PlotStyle(true,false);
plot_down = PlotStyle(false,true);

[line_segments] = segment_full_text_by_lines(word);

line = line_segments(1);

path_folder = pwd;

plot_animation( line, plot_down , strcat( path_folder , '\my_gif_on_tablet.gif') , 1 ,  'k' )
plot_animation( line, plot_all  , strcat( path_folder , '\my_gif_on_tablet_on_air.gif') , 2 ,  'k' )


