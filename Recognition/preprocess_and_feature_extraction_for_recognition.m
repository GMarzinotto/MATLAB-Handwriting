function [ features ] = preprocess_and_feature_extraction_for_recognition( Word )

    %discard on air tracking
    word_on_tablet = discard_penup_tracking_information( Word );

    %center the word sample
    centredWord   = center_word( word_on_tablet );
    
    %rescale word
    rescaledWord  = rescale_word( centredWord );
    
    %apply a lowpass filter
    myFilter = Lowpass_Filter();
    filteredWord  = filter_word( rescaledWord , myFilter );
   
    %resample the word dist = 0.01cm
    resampled_word = resample_word(filteredWord);
    
    %correct slant
    no_slant_word = correct_word_horizontal_slant( resampled_word );

    features  = feature_extraction_for_recognition(no_slant_word);
    
end