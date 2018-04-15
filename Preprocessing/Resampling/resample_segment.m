function [newWord] = resample_segment(Segment , resampleDistance)
%% resample_segment
%  Applies Resampling to a Word Struct segment making all the contiguous  
%  points in Word to have the same constant and fixed distance. To do this
%  the function may remove points that are too close and interpolate points
%  that are too far. a Segment input is a continuous stroke where the track
%  of the pen is not lost at any time, it can contain penups if tracking on
%  air is enabled. 
%
% [ _newWord_ ] = _*resample_segment*_ ( _Word_ )
%
%%% Inputs
% 
% * *Segment*  : A Word Struct as defined in this framework 
%                see wordStruct documentation. 
%
% * *resampleDistance* : Resampling distance in cm. 
%
%%% Outputs
% 
% * *newWord* : A new Word Struct, containing a field Resampled
%                   
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    
    %Init the resampled digit with the first point of the input
    X = Segment.X(1);
    Y = Segment.Y(1);
    P = Segment.P(1);
    T = Segment.T(1);
    if (isfield(Segment,'Az'))
        Az = Segment.Az(1);
    end
    if (isfield(Segment,'Al'))
        Al = Segment.Al(1);
    end
       
    nSamples = Segment.NumSamples;
    
    %Loop through the whole file
    for k=1:nSamples-1
        
        prev_val_x  = X(end);
        prev_val_y  = Y(end);
        prev_val_p  = P(end);
        prev_val_t  = T(end);
        if (isfield(Segment,'Al'))
            prev_val_al = Al(end);
        end
        if (isfield(Segment,'Az'))
            prev_val_az = Az(end);
        end
        highIDX = k+1;
        
        %Find the next point of the sequence at 
        %Reesampling distance or a larger distance
        %Distance is computed only using XYZ coordinates
        %This will remove all the points that too close
        if((highIDX<nSamples)&&...
                ( norm( [prev_val_x prev_val_y] - [Segment.X(highIDX) Segment.Y(highIDX)] ) < resampleDistance ))
            continue;
        end
        
        %Interpolate between the two points to ensure exact distance
        %If it is equal there is nothing to do
        if(norm([prev_val_x prev_val_y] - [Segment.X(highIDX) Segment.Y(highIDX)])==resampleDistance)
            X = [X; Segment.X(highIDX)];  
            Y = [Y; Segment.Y(highIDX)];  
            P = [P; Segment.P(highIDX)];  
            T = [T; Segment.T(highIDX)];  
            if (isfield(Segment,'Az'))
                Az = [Az; Segment.Az(highIDX)];
            end
            if (isfield(Segment,'Al'))
                Al = [Al; Segment.Al(highIDX)];
            end
            
        %If it is larger, we have to interpolate
        else
            %All the features have to be interpolated
            %But the distance to be considered is still in XY
            %We interpolate points untill we reach the resample distance
            while ( (highIDX<nSamples) && ...
                    ( norm([prev_val_x prev_val_y] - [Segment.X(highIDX) Segment.Y(highIDX)]) > resampleDistance ) )
                
                distValue = norm([prev_val_x prev_val_y] - [Segment.X(highIDX) Segment.Y(highIDX)]);
                
                
                dx = Segment.X(highIDX) - prev_val_x;
                dy = Segment.Y(highIDX) - prev_val_y;
                dp = Segment.P(highIDX) - prev_val_p;
                dt = Segment.T(highIDX) - prev_val_t;
                if (isfield(Segment,'Al'))
                    dal = Segment.Al(highIDX) - prev_val_al;
                end
                if (isfield(Segment,'Az'))
                    daz = Segment.Az(highIDX) - prev_val_az;
                end
               
                
                
                newPoint_x = prev_val_x + dx*(resampleDistance/distValue);
                newPoint_y = prev_val_y + dy*(resampleDistance/distValue);
                if((resampleDistance/distValue) > 0.25 && Segment.P(highIDX) == 0)
                    newPoint_p = 0;
                else
                    newPoint_p = prev_val_p + dp*(resampleDistance/distValue);
                end
                newPoint_t = prev_val_t + dt*(resampleDistance/distValue);
                if (isfield(Segment,'Az'))
                    newPoint_az = prev_val_az + daz*(resampleDistance/distValue);
                end
                if (isfield(Segment,'Al'))
                    newPoint_al = prev_val_al + dal*(resampleDistance/distValue);
                end
                
                
                X = [X; newPoint_x];  
                Y = [Y; newPoint_y];  
                P = [P; newPoint_p];  
                T = [T; newPoint_t];  
                if (isfield(Segment,'Az'))
                    Az = [Az; newPoint_az];
                end
                if (isfield(Segment,'Al'))
                    Al = [Al; newPoint_al];
                end
    

                prev_val_x  = X(end);
                prev_val_y  = Y(end);
                prev_val_p  = P(end);
                prev_val_t  = T(end);
                if (isfield(Segment,'Az'))
                    prev_val_az = Az(end);
                end
                if (isfield(Segment,'Al'))
                    prev_val_al = Al(end);
                end
                
            end       
        end   
    end
    
    if( Segment.NumSamples > 1 && length(X) == 1 )
        
        newWord.X = [ Segment.X(1); Segment.X(end) ];
        newWord.Y = [ Segment.Y(1); Segment.Y(end) ];
        newWord.T = [ Segment.T(1); Segment.T(end) ];
        newWord.P = [ Segment.P(1); Segment.P(end) ];
        if (isfield(Segment,'Al'))
            newWord.Al = [ Segment.Al(1); Segment.Al(end) ];
        end
        if (isfield(Segment,'Az'))
            newWord.Az = [ Segment.Az(1); Segment.Az(end) ];
        end
        
    else
        
    

        newWord.X = X;
        newWord.Y = Y;
        newWord.T = T;
        newWord.P = P;
        if (isfield(Segment,'Al'))
            newWord.Al = Al;
        end
        if (isfield(Segment,'Az'))
            newWord.Az = Az;
        end
    
    end
    
    newWord.NumSamples   = length( newWord.X );
    newWord.SamplePeriod = max([diff(newWord.T); Segment.SamplePeriod]);
    newWord.Tracking     = compute_word_tracking_type(newWord);
       
    if (isfield(Segment,'Metadata'))
        newWord.Metadata = Segment.Metadata;
    end

end