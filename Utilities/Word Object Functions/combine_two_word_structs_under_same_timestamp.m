function [ Combined_Word ] = combine_two_word_structs_under_same_timestamp( Word1 , Word2 , safe_mode )

    if( nargin < 3 )
        safe_mode = true;
    end

    if(safe_mode)
        %if the words overlap, send an error message
        if ( any( Word1.T >= Word2.T(1) ) && any( Word2.T <= Word1.T(end) ) )
            error( 'These Words Overlap in Time! They Cannot be Merged!' );
        end

        %if the words are sampled at different frequencies, send an error message
        if( Word1.SamplePeriod ~= Word2.SamplePeriod )
            error( 'Words have different sampling period, they cannot be merged...' );
        end
    end
            
        %if Word2 occured before Word1 they must swap
        if( Word1.T(1) > Word2.T(end) )
            WordAux = Word1;
            Word1 = Word2;
            Word2 = WordAux;
        end

    
    
    Combined_Word.X = [ Word1.X ; Word2.X ];
    Combined_Word.Y = [ Word1.Y ; Word2.Y ];
    Combined_Word.P = [ Word1.P ; Word2.P ];
    Combined_Word.T = [ Word1.T ; Word2.T ];
    
    if( isfield(Word1,'Al') && isfield(Word2 ,'Al')  )
        Combined_Word.Al = [ Word1.Al ; Word2.Al ];
    end
    
    if( isfield(Word1,'Az') && isfield(Word2 ,'Az')  )
        Combined_Word.Az = [ Word1.Az ; Word2.Az ];
    end
    
    if( isfield(Word1,'ContentType') && isfield(Word2,'ContentType') ) 
        Combined_Word.ContentType = Word1.ContentType;   
    end
    
    Combined_Word.SamplePeriod = Word1.SamplePeriod; 
    Combined_Word.NumSamples = Word1.NumSamples + Word2.NumSamples;
    Combined_Word.Tracking   = compute_word_tracking_type(Combined_Word);
    
    
    if( Word2.T(1) - Word1.T(end) > 2*Combined_Word.SamplePeriod || isinf(Word1.SamplePeriod) || isinf(Word2.SamplePeriod) )
        Combined_Word.LostOfTrackPoints = [ Word1.LostOfTrackPoints   Word1.NumSamples   (Word2.LostOfTrackPoints + Word1.NumSamples) ];
    else
        Combined_Word.LostOfTrackPoints = [ Word1.LostOfTrackPoints   (Word2.LostOfTrackPoints + Word1.NumSamples) ];
    end
    
    
end