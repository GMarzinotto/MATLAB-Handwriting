function [test_result] = is_a_valid_word_struct(Word)

    test_result = true;
    
    if(~isfield(Word,'X') || ~isfield(Word,'Y') || ~isfield(Word,'T') || ~isfield(Word,'P') || ~isfield(Word,'SamplePeriod') || ~isfield(Word,'LostOfTrackPoints') || ~isfield(Word,'LostOfTrackPoints') )
        test_result = false;
    else if( length(Word.X) ~= length(Word.Y) || length(Word.X) ~= length(Word.P) || length(Word.X) ~= length(Word.T) || length(Word.X) ~= Word.NumSamples )
            test_result = false;
        else if ( ~strcmp(Word.Tracking,'ON_TABLET') &&   ~strcmp(Word.Tracking,'ON_AIR') &&  ~strcmp(Word.Tracking,'ON_TABLET_ON_AIR') )
                test_result = false;
            end
        end  
    end


end