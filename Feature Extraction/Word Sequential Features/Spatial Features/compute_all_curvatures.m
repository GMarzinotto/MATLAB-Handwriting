function [  angle_deg , angle_rad , Trigonometry ] = compute_all_curvatures( Word , window_size )
%% compute_all_curvatures
%  Computes all the local curvature values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The curvature computed at the instants T where the tablet
%  losses track of the pen may be invalid. To ensure these values
%  are removed use compute_valid_curvatures function
%
% [ _angle_deg_ , _angle_rad_ , _Trigonometry_  ] = _*compute_all_curvatures*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *window_size* : Number of observations to the left, and to the right to 
%                   be considered, when computing the curvature angle
%
%%% Outputs
% 
% * *angle_deg*  : An array containing all the inclination angles of Word
%                  in degrees Size of inclinations is Word.NumSamples -1
%
% * *angle_rad*  : An array containing all the inclination angles of Word
%                  in radians Size of inclinations is Word.NumSamples -1
%
% * *Trigonometry*  : An struct contaning arrays of the standard trigonometric
%                     functions applied to the inclination angles of Word
%                     in radians Size of inclinations is Word.NumSamples -1
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if window_size < 1 || window_size > 100
        error('Provide a valid window size');
    end
        
    %compute all the differences of Window Size range.
	dParamX = Word.X(window_size+1:end) - Word.X(1:end-window_size);
    dParamY = Word.Y(window_size+1:end) - Word.Y(1:end-window_size);
    
    unitary_vec = [];
    
    for k=1:length(dParamX)
        norma = norm([dParamX(k) dParamY(k)],2);
        unitary_vec = [unitary_vec; [[dParamX(k) dParamY(k)]/norma]];
    end
    
    angle_rad = real(acos(sum( ...
                        unitary_vec(1:end-window_size,:).*unitary_vec(window_size+1:end,:)...
                    ,2)));
   
   
    
    Trigonometry.sin_angle_0_180 = sin(angle_rad);
    Trigonometry.cos_angle_0_180 = cos(angle_rad);
    Trigonometry.tan_angle_0_180 = tan(angle_rad);
    Trigonometry.cot_angle_0_180 = cot(angle_rad);
    Trigonometry.sec_angle_0_180 = sec(angle_rad);
    Trigonometry.csc_angle_0_180 = csc(angle_rad);
    
    
    Trigonometry.sinh_angle_0_180 = sinh(angle_rad);
    Trigonometry.cosh_angle_0_180 = cosh(angle_rad);
    Trigonometry.tanh_angle_0_180 = tanh(angle_rad);
    Trigonometry.coth_angle_0_180 = coth(angle_rad);
    Trigonometry.sech_angle_0_180 = sech(angle_rad);
    Trigonometry.csch_angle_0_180 = csch(angle_rad);
    
    
    angle_deg = radtodeg(angle_rad);

end