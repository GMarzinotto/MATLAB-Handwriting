function [] = plot_k_writer_words( Writer , All_Words , number_of_words )

    writer_words = All_Words(strcmp( {All_Words.Writer_ID} , Writer.Writer_ID));
    
    writer_words = writer_words( randperm( length(writer_words),min(number_of_words,length(writer_words)) ) );
    
    %plot on tablet
    mystyle = PlotStyle(false,true);
    for k=1:length(writer_words)
        figure(),
        subplot(2,3,1), plot_jerk_module(writer_words(k),mystyle);
        subplot(2,3,2), plot_speed_module(writer_words(k),mystyle);
        subplot(2,3,3), plot_curvature_angle(resample_word( writer_words(k) ),10,mystyle);
        subplot(2,3,4), plot_inclination_angle_0_180(writer_words(k),mystyle);
        subplot(2,3,5), plot_pressure(writer_words(k),mystyle);
        subplot(2,3,6), plot_pressure_derivative_wrt_time(writer_words(k),mystyle);
    end


end