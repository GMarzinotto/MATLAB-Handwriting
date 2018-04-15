word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

myFilter = Lowpass_Filter();
[filteredWord] = filter_word(word , myFilter);

%Resample using the default distance 0.01cm
[resampleWord] = resample_word( word ); 


plot_all  = PlotStyle(true,true);
plot_up   = PlotStyle(true,false);
plot_down = PlotStyle(false,true);

[line_segments] = segment_full_text_by_lines(word);

word = line_segments(3);


figure(),
subplot(3,1,1), plot_curvature_angle(word,10,plot_down),  title('Curvature PENDOWN. Window=10')
subplot(3,1,2), plot_inclination_angle_0_90(word,plot_down),  title('Inclination 0-90 PENDOWN')
subplot(3,1,3), plot_inclination_angle_0_180(word,plot_down),  title('Inclination 0-180 PENDOWN')


figure(),
subplot(3,1,1), plot_curvature_angle(word,10,plot_all),   title('Curvature PENDOWN PENUP. Window=10')
subplot(3,1,2), plot_curvature_angle(word,10,plot_down),  title('Curvature PENDOWN. Window=10')
subplot(3,1,3), plot_curvature_angle(word,10,plot_up),    title('Curvature PENUP. Window=10')

figure(),
subplot(3,1,1), plot_inclination_angle_0_90(word,plot_all),   title('Inclination 0-90 PENDOWN PENUP')
subplot(3,1,2), plot_inclination_angle_0_90(word,plot_down),  title('Inclination 0-90 PENDOWN')
subplot(3,1,3), plot_inclination_angle_0_90(word,plot_up),    title('Inclination 0-90 PENUP')

figure(),
subplot(3,1,1), plot_inclination_angle_0_180(word,plot_all),   title('Inclination 0-180 PENDOWN PENUP')
subplot(3,1,2), plot_inclination_angle_0_180(word,plot_down),  title('Inclination 0-180 PENDOWN')
subplot(3,1,3), plot_inclination_angle_0_180(word,plot_up),    title('Inclination 0-180 PENUP')

figure(),
subplot(3,1,1), plot_inclination_angle_0_360(word,plot_all),   title('Inclination 0-360 PENDOWN PENUP')
subplot(3,1,2), plot_inclination_angle_0_360(word,plot_down),  title('Inclination 0-360 PENDOWN')
subplot(3,1,3), plot_inclination_angle_0_360(word,plot_up),    title('Inclination 0-360 PENUP')

