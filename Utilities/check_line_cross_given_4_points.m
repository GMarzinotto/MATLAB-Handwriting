function [ bool_cross , cross_point ] = check_line_cross_given_4_points( segment1_start, segment1_end , segment2_start , segment2_end )
%% check_line_cross_given_4_points
%  check if Segment 1 crosses with the Segment 2 on the XY plane,  
%
%
% [ _bool_cross_ , _cross_point_ ] = _*check_line_cross_given_4_points*_ ( _segment1_start_ , _segment1_end_ , _segment2_start_ , _segment2_end_ )
%
%%% Inputs
% 
% * *segment1_start* :  Coordiantes X Y of the start point of Segment 1. 
%
% * *segment1_end*   :  Coordiantes X Y of the end point of Segment 1. 
%
% * *segment2_start* :  Coordiantes X Y of the start point of Segment 2.  
%
% * *segment2_end*   :  Coordiantes X Y of the end point of Segment 2. 
%
%%% Outputs
% 
% * *bool_cross*  : True if segments cross, false otherwise
%
% * *cross_point* : Coordiantes X Y of the crossing point of both segments. 
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    ep = 0.0001;
    bool_cross = false;
    cross_point.X = [];
    cross_point.Y = [];
    
    if(~( max( segment1_end.Y , segment1_start.Y ) <  min( segment2_end.Y , segment2_start.Y ) || ...
          min( segment1_end.Y , segment1_start.Y ) >  max( segment2_end.Y , segment2_start.Y ) || ...
          max( segment1_end.X , segment1_start.X ) <  min( segment2_end.X , segment2_start.X ) || ...
          min( segment1_end.X , segment1_start.X ) >  max( segment2_end.X , segment2_start.X ) ))
     
      
      if( (segment1_end.Y == segment1_start.Y  &&  segment1_end.X == segment1_start.X) || (segment2_end.Y == segment2_start.Y  &&  segment2_end.X == segment2_start.X) )
          
          %If the 2 segments are just 2 points, we check for equality.
          if( (segment1_end.Y == segment1_start.Y  &&  segment1_end.X == segment1_start.X) && (segment2_end.Y == segment2_start.Y  &&  segment2_end.X == segment2_start.X) )
              if( segment1_end.Y == segment2_end.Y && segment1_end.X == segment2_end.X )
                  cross_point.X = segment1_end.X;
                  cross_point.Y = segment1_end.Y;
                  bool_cross = true;
              else
                  bool_cross = false;
              end  
          %If only the segment 1 is a point and the segment 2 is a line
          else if( (segment1_end.Y == segment1_start.Y  &&  segment1_end.X == segment1_start.X) )
                  
                  vector  = [ (segment2_end.X - segment2_start.X)  (segment2_end.Y - segment2_start.Y) ];
                  delta_x = abs(segment1_end.X - segment2_start.X);
                  interpolation =  [  ( vector(1)*delta_x + segment2_start.X )  ( vector(2)*delta_x + segment2_start.Y ) ];
                  Distance = pdist( [ interpolation ;  segment1_end.X segment1_end.Y ] );
                  if( Distance < ep )
                      cross_point.X = segment1_end.X;
                      cross_point.Y = segment1_end.Y;
                      bool_cross = true;
                  else
                      bool_cross = false;
                  end
                  
              %Else means only the segment 2 is a point and the segment 1 is a line, so we do similar as above    
              else 
                  
                  vector  = [ (segment1_end.X - segment1_start.X)  (segment1_end.Y - segment1_start.Y) ];
                  delta_x = abs(segment2_end.X - segment1_start.X);
                  interpolation =  [  ( vector(1)*delta_x + segment1_start.X )  ( vector(2)*delta_x + segment1_start.Y ) ];
                  Distance = pdist( [ interpolation ;  segment2_end.X segment2_end.Y ] );
                  if( Distance < ep )
                      cross_point.X = segment2_end.X;
                      cross_point.Y = segment2_end.Y;
                      bool_cross = true;
                  else
                      bool_cross = false;
                  end
                  
              end
          end
          
      else
      
            M1 = (segment1_end.Y - segment1_start.Y)/(segment1_end.X - segment1_start.X);
            M2 = (segment2_end.Y - segment2_start.Y)/(segment2_end.X - segment2_start.X);

            if isinf(M1)
                if( segment1_end.Y > segment1_start.Y ) 
                    M1 = 9999999;
                else
                    M1 = -9999999;
                end
            end


            if isinf(M2)
                if( segment2_end.Y > segment2_start.Y ) 
                    M2 = 9999999;
                else
                    M2 = -9999999;
                end
            end

            A = [-M1 1; -M2 1];
            B = [( segment1_start.Y - M1*segment1_start.X ); ( segment2_start.Y - M2*segment2_start.X )];
            solution = linsolve(A,B);

            if ~(isnan(solution(1)) || isnan(solution(2)))


                if (solution(1) >= min([ segment1_start.X segment1_end.X ])-ep) && (solution(1) >= min([ segment2_start.X segment2_end.X ])-ep) && ...
                   (solution(1) <= max([ segment1_start.X segment1_end.X ])+ep) && (solution(1) <= max([ segment2_start.X segment2_end.X ])+ep) && ...
                   (solution(2) >= min([ segment1_start.Y segment1_end.Y ])-ep) && (solution(2) >= min([ segment2_start.Y segment2_end.Y ])-ep) && ...
                   (solution(2) <= max([ segment1_start.Y segment1_end.Y ])+ep) && (solution(2) <= max([ segment2_start.Y segment2_end.Y ])+ep)

                    bool_cross = true;

                end

                if abs(M1 - M2)<ep
                    bool_cross = false;
                end

            end
            cross_point.X = solution(1);
            cross_point.Y = solution(2);
      end
    end
    
end