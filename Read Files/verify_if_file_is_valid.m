function [ is_valid , time_error_indexes_ms ] = verify_if_file_is_valid( Word )

    is_valid = true;
    time_error_indexes_ms = [];
    if(any(diff(Word.T)<=0));
        time_error_indexes_ms = Word.T(diff(Word.T)<=0)*1000;
        is_valid = false;
        warning('Invalid File, Time Component has negative steps, this will cause NaNs in calculations. Please verify Time Coordinates T = %s' , num2str(time_error_indexes_ms(1)) );
    end

    time_error_indexes_ms = int64(unique(time_error_indexes_ms));
    
end