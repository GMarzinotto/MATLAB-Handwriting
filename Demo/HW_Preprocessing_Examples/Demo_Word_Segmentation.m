[ word ] = read_file_wacom_app('\Demo\Demo Database\Wacom\PERSON0\Test1.txt');

pStyle = PlotStyle( false,true );


figure(),
plot_in_black_and_white(word,pStyle) 

[line_segments] = segment_full_text_by_lines(word);

nsegments = length(line_segments);


figure(),
for k=1:nsegments
    subplot(nsegments,1,k), plot_in_black_and_white(line_segments(k),pStyle) 
end


word_list = [];
figure(),
for k=1:nsegments
    %[ iWord_segments ] = segment_by_word_estimates_using_bitmap( line_segments(k) , n_words);
    [ iWord_segments ] = segment_by_words( line_segments(k) );
    word_list = [word_list; iWord_segments];
end

ncols = 6;
nrows = floor(length(word_list)/ncols  + 1);

for j=1:length(word_list)
    subplot(nrows,ncols, j), plot_in_black_and_white(word_list(j),pStyle) 
end
