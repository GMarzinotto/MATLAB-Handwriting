function [ no_skew_word , shear_angle ] = correct_word_horizontal_slant( Word )


    [ shear_angle ] = compute_horizontal_slant_angle( Word );
    [ no_skew_word ] = shear_online_word_horizontally( Word , shear_angle );

end