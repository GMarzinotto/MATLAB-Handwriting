function [ valid_word_size ] = is_line_large_enough( Word )

    if(strcmp(Word.Tracking,'ON_AIR'))
        valid_word_size = false;
    else
                
        n_strokes = compute_number_of_strokes( Word , 'ON_TABLET' , 'PENUP_CRITERION' );

        if( n_strokes == 0 )
            valid_word_size = false;
        else

            str_length_l2  = compute_strokes_lengths( Word , 'ON_TABLET' , 'PENUP_CRITERION' );
            sum_str_length = sum(str_length_l2);

            x_length = compute_word_horizontal_and_vertical_lengths( Word );

            if( sum_str_length < 2.5 || x_length < 2.0 )
                valid_word_size = false;
            else
                [ local_min , local_max ] = compute_local_minima_and_local_maxima(Word , 'ON_TABLET' );
                if( length(local_min.X) < 4 || length(local_max.X) < 4 )
                    valid_word_size = false;
                else
                    valid_word_size = true;
                end
            end

        end
    end

end