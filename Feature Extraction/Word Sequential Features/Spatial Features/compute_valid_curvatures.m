function [  angle_0_180 , angle_rad_0_pi , Trigonometry ] = compute_valid_curvatures( Word , window_size )
%% compute_valid_curvatures
%  Computes the valid local curvature values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The curvatures computed at the instants T where the tablet
%  losses track of the pen are discarted. Therefore, the indexes in the
%  output vectors may not be directly correlated to the indexes in the Word
%  struct. To ensure the order is kept use compute_all_curvatures function
%
% [ _valid_angle_deg_abs_ , _valid_angle_rad_abs_ , _Trigonometry_  ] = _*compute_valid_curvatures*_ ( _Word_ , _window_size_ )
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
% * *angle_deg*  : An array containing all the curvature angles of Word
%                  in degrees Size of inclinations is Word.NumSamples -
%                  2*window_size
%
% * *angle_rad*  : An array containing all the curvature angles of Word
%                  in radians Size of inclinations is Word.NumSamples -
%                  2*window_size
%
% * *Trigonometry*  : An struct contaning arrays of the standard trigonometric
%                     functions applied to the curvature angles of Word
%                     in radians Size of inclinations is Word.NumSamples - 
%                     2*window_size
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if (window_size < 1 || window_size > 100)
        error('Provide a valid window size');
    end
        
    if( ~isempty(Word) && Word.NumSamples > 2*window_size ) 
            
        %compute all the differences of Window Size range.
        dParamX = Word.X(window_size+1:end) - Word.X(1:end-window_size);
        dParamY = Word.Y(window_size+1:end) - Word.Y(1:end-window_size);

        unitary_vec = [];
        for k=1:length(dParamX)
            norma = norm([dParamX(k) dParamY(k)],2);
            unitary_vec = [unitary_vec; [[dParamX(k) dParamY(k)]/norma]];
        end

        angle_rad_abs = real(acos(sum( ...
                            unitary_vec(1:end-window_size,:).*unitary_vec(window_size+1:end,:)...
                        ,2)));

        %Remove Invalid Values due to Penup and NaNs
        invalid_values = Word.LostOfTrackPoints;
        for k=1:(2*window_size  - 1)
            invalid_values = [ invalid_values (Word.LostOfTrackPoints-k) ];
        end
        invalid_values(invalid_values < 1 | invalid_values > length(angle_rad_abs)) = [];
        invalid_values = unique(invalid_values);

        angle_rad_0_pi = angle_rad_abs;
        angle_rad_0_pi(invalid_values) = [];
        angle_rad_0_pi(isnan(angle_rad_0_pi) | isinf(angle_rad_0_pi)) = [];

        Trigonometry.sin_angle_0_180 = sin(angle_rad_0_pi);
        Trigonometry.cos_angle_0_180 = cos(angle_rad_0_pi);
        Trigonometry.tan_angle_0_180 = tan(angle_rad_0_pi);
        Trigonometry.cot_angle_0_180 = cot(angle_rad_0_pi);
        Trigonometry.sec_angle_0_180 = sec(angle_rad_0_pi);
        Trigonometry.csc_angle_0_180 = csc(angle_rad_0_pi);


        Trigonometry.sinh_angle_0_180 = sinh(angle_rad_0_pi);
        Trigonometry.cosh_angle_0_180 = cosh(angle_rad_0_pi);
        Trigonometry.tanh_angle_0_180 = tanh(angle_rad_0_pi);
        Trigonometry.coth_angle_0_180 = coth(angle_rad_0_pi);
        Trigonometry.sech_angle_0_180 = sech(angle_rad_0_pi);
        Trigonometry.csch_angle_0_180 = csch(angle_rad_0_pi);


        angle_0_180 = radtodeg(angle_rad_0_pi);
    
    else
        
        angle_0_180 = []; 
        angle_rad_0_pi = [];
        Trigonometry = [];
        
    end

end