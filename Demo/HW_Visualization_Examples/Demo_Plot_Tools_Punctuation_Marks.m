word = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON8\Test1.txt');

plot_down = PlotStyle(false,true);


figure(),
plot_punctuation_mark_strokes_detection(word,plot_down),   title('Position PENDOWN')

figure(),
plot_punctuation_mark_strokes_classification(word,plot_down),   title('Position PENDOWN')

