function [all_segments, penup_segments, pendown_segments, separators] = segment_by_strokes_vx_vy_criterion(Word)
%% segment_by_strokes_vx_vy_criterion
%  Takes a Word and produces a list of Word Struct where 
%  each word corresponds to a continuous segment on tablet
%  or a continuous segment on air. These strokes are returned
%  in three lists considering only on tablet, only on air and both.
%  The Criterion for the segmentation in this function is that each stroke 
%  must have a continuous sign in the X speed and Y speed. 
%
% [ _all_segments_ , _penup_segments_ , _pendown_segments_ , _separators_ ] = _*segment_by_strokes_vx_vy_criterion*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*        : A Word Struct as defined in this framework 
%                   see wordStruct documentation. 
%
%%% Outputs
% 
% * *_all_segments_* : An array of Word Structs as defined in this framework 
%                             considering all possible strokes cosidering
%                             that a stroke ends when Vy changes sign or
%                             when a penup takes place
%
% * *_penup_segments_*   : An array of Word Structs as defined in this framework 
%                          considering all the strokes on pen up (on air)
%                          a stroke ends when Vy changes sign
%                             
% * *_pendown_segments_* : An array of Word Structs as defined in this framework 
%                          considering all strokes on pen down
%                          a stroke ends when Vy changes sign.
%
% * *separators* :  A Matrix containing the markers for each segment
%                   the first column contains the initial point of each  
%                   segment and the second colum the final point.
%                   each row stands for a segment. 
%

    
        
    penup_segments   = [];
    pendown_segments = [];
    all_segments     = [];
    separators       = [];

    [all_segments_pen_up_down, ~ , ~ , separators_penups ] = segment_by_penups_pendowns(Word);
    globalIDX = 1;
    
    for k=1:length(all_segments_pen_up_down)
        [ ~, vx ,vy ] = compute_all_speeds(all_segments_pen_up_down(k));
        j = 1;
        globalIDX = separators_penups(k,1);
        while (j < length(vx)-1)
            init_point  = j;
            init_global = globalIDX;
            if(vx(j)>=0)
                startSign_vx   =  1;
            else 
                startSign_vx   = -1;
            end
            
            if(vy(j)>=0)
                startSign_vy   =  1;
            else 
                startSign_vy   = -1;
            end
            
            while(j < length(vx)-1 && (    ((sign(vx(j+1)) >= 0 && startSign_vx   ==  1) || (sign(vx(j+1)) <= 0 && startSign_vx   ==  -1))...
                                        || ((sign(vy(j+1)) >= 0 && startSign_vy   ==  1) || (sign(vy(j+1)) <= 0 && startSign_vy   ==  -1)) ))
                j         = j+1;
                globalIDX = globalIDX + 1;
            end
            end_point  = j;
            end_global = globalIDX;
            
            iWord      = all_segments_pen_up_down(k);
            iSegment   = iWord;
            iSegment.X = iWord.X(init_point:end_point); 
            iSegment.Y = iWord.Y(init_point:end_point); 
            iSegment.P = iWord.P(init_point:end_point); 
            iSegment.T = iWord.T(init_point:end_point); 
            if (isfield(iWord,'Az'))
                iSegment.Az = iWord.Az(init_point:end_point); 
            end
            if (isfield(iWord,'Al'))
                iSegment.Al = iWord.Al(init_point:end_point); 
            end
            iSegment.NumSamples  = length(iSegment.X);
            iSegment.SamplePeriod       = Word.SamplePeriod;
            iSegment.LostOfTrackPoints  = [];
            iSegment.FileType  = 'STROKE';
            
            
            if(sum(iSegment.P)==0)
                iSegment.Tracking = 'ON_AIR';
                penup_segments = [penup_segments; iSegment];
            else
                if(sum(iSegment.P==0)==0)
                    iSegment.Tracking = 'ON_TABLET';
                    pendown_segments = [pendown_segments; iSegment];
                end
            end
            
            
            all_segments = [all_segments; iSegment];
            separators   = [separators; [init_global end_global+1]];
            
            globalIDX = globalIDX + 1;
            j         = j+1;
            
        end
        
    end
    

end