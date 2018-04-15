[ word ] = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test5.txt');

myFilter = Lowpass_Filter();
[filteredWord] = filter_word(word , myFilter);

%Resample using the default distance 0.01cm
[resampleWord] = resample_word( word ); 

figure(),
subplot(1,3,1), plot_speed_module(word);
subplot(1,3,2), plot_speed_module(filteredWord);
subplot(1,3,3), plot_speed_module(resampleWord);