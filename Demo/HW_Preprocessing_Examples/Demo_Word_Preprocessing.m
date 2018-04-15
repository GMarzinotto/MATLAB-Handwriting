[ word ] = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON5\Test1.txt');

pStyle = PlotStyle( false,true );


[line_segments] = segment_full_text_by_lines(word);
line = center_word(line_segments(3));
%line = line_segments(5);

myFilter = Lowpass_Filter();
filteredWord = filter_word(line , myFilter);

%Resample using the default distance 0.01cm
resampleWord = resample_word( filteredWord ); 

%Fix Skew
no_skew_word = correct_skew_online( resampleWord );

%Correct Slant
[no_slant_word , slant] = correct_word_horizontal_slant( no_skew_word );

figure(),
ax1 = subplot(5,1,1); plot_in_black_and_white(line,pStyle);             title('Original Text')
ax2 = subplot(5,1,2); plot_in_black_and_white(filteredWord,pStyle);     title('Low-Pass Filtered Text')
ax3 = subplot(5,1,3); plot_in_black_and_white(resampleWord,pStyle);     title('Resampled Text')
ax4 = subplot(5,1,4); plot_in_black_and_white(no_skew_word,pStyle);     title('Fixed Skew Text')
ax5 = subplot(5,1,5); plot_in_black_and_white(no_slant_word,pStyle);    title('Fixed Slant Text')

linkaxes([ax2,ax3,ax4,ax5,ax1],'x')

