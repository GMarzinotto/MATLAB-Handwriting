function [ angle_deg_0_360 , angle_deg_0_180 , angle_deg_0_90 , Trigonometry ] = compute_valid_inclinations(Word)
%% compute_valid_inclinations
%  Computes the valid local inclination values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The inclination computed at the instants T where the tablet
%  losses track of the pen are discarted. Therefore, the indexes in the
%  output vectors may not be directly correlated to the indexes in the Word
%  struct. To ensure the order is kept use compute_all_inclinations functions
%
% [ _angle_deg_0_360_ , _angle_deg_0_180_ , _angle_deg_0_90_ , _Trigonometry_  ] = _*compute_valid_inclinations*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *angle_deg_0_360*  : An array containing all the inclination angles of 
%                        Word in degrees using the interval [0 360] 
%
% * *angle_deg_0_180*  : An array containing all the inclination angles of 
%                        Word in the interval [0 180] value in degrees.
%                        This is done by taking the complement of the
%                        negative inclination angles, being these positive
%                        
% * *angle_deg_0_90*  :  An array containing all the inclination angles of 
%                        Word in in the interval [0 90] value in degrees.
%                        This is done to measure the separation to the
%                        vertical, applying simetry w.r.t the vertical.
%
% * *Trigonometry*  : An struct contaning arrays of the standard trigonometric
%                     functions applied to the inclination angles.
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

    if( ~isempty(Word) && Word.NumSamples > 1 ) 
        
        %compute all the X,Y differentials values
        dParamX = diff(Word.X);
        dParamY = diff(Word.Y);

        %Compute inclination angle [0 2*pi]
        angle_rad_0_2pi  = atan2(dParamY,dParamX);

        %clean values where the track of the pen is lost
        invalid_values = Word.LostOfTrackPoints;
        invalid_values(invalid_values < 1 | invalid_values > length(angle_rad_0_2pi)) = [];
        angle_rad_0_2pi(invalid_values) = [];
        angle_rad_0_2pi(isnan(angle_rad_0_2pi) | isinf(angle_rad_0_2pi)) = [];


        %Trigonometric functions on the angles in [0 2*pi]
        Trigonometry.sin_angle_0_360 = sin(angle_rad_0_2pi);
        Trigonometry.cos_angle_0_360 = cos(angle_rad_0_2pi);
        Trigonometry.tan_angle_0_360 = tan(angle_rad_0_2pi);
        Trigonometry.cot_angle_0_360 = cot(angle_rad_0_2pi);
        Trigonometry.sec_angle_0_360 = sec(angle_rad_0_2pi);
        Trigonometry.csc_angle_0_360 = csc(angle_rad_0_2pi);

        %Trigonometric hyperbolic functions on the angles in [0 2*pi]
        Trigonometry.sinh_angle_0_360 = sinh(angle_rad_0_2pi);
        Trigonometry.cosh_angle_0_360 = cosh(angle_rad_0_2pi);
        Trigonometry.tanh_angle_0_360 = tanh(angle_rad_0_2pi);
        Trigonometry.coth_angle_0_360 = coth(angle_rad_0_2pi);
        Trigonometry.sech_angle_0_360 = sech(angle_rad_0_2pi);
        Trigonometry.csch_angle_0_360 = csch(angle_rad_0_2pi);

        % To convert from 0-2pi to 0-pi we take que complement of the negative
        % angles (this is equivalent to add +pi to negative angles)
        % This configuration ignores the sense in which the traits are performe
        angle_rad_0_pi = angle_rad_0_2pi;
        angle_rad_0_pi( angle_rad_0_2pi <= 0 ) = angle_rad_0_pi( angle_rad_0_2pi <= 0 ) + pi; 


        %Trigonometric functions on the angles in [0 pi]
        Trigonometry.sin_angle_0_180 = sin(angle_rad_0_pi);
        Trigonometry.cos_angle_0_180 = cos(angle_rad_0_pi);
        Trigonometry.tan_angle_0_180 = tan(angle_rad_0_pi);
        Trigonometry.cot_angle_0_180 = cot(angle_rad_0_pi);
        Trigonometry.sec_angle_0_180 = sec(angle_rad_0_pi);
        Trigonometry.csc_angle_0_180 = csc(angle_rad_0_pi);

        %Trigonometric hyperbolic functions on the angles in [0 pi]
        Trigonometry.sinh_angle_0_180 = sinh(angle_rad_0_pi);
        Trigonometry.cosh_angle_0_180 = cosh(angle_rad_0_pi);
        Trigonometry.tanh_angle_0_180 = tanh(angle_rad_0_pi);
        Trigonometry.coth_angle_0_180 = coth(angle_rad_0_pi);
        Trigonometry.sech_angle_0_180 = sech(angle_rad_0_pi);
        Trigonometry.csch_angle_0_180 = csch(angle_rad_0_pi);


        angle_deg_0_360 = radtodeg(angle_rad_0_2pi);

        % To convert from 0-360 to 0-180 we take que complement of the negative
        % angles (this is equivalent to add +180 to negative angles)
        % This configuration ignores the sense in which the traits are performe
        angle_deg_0_180 = angle_deg_0_360;
        angle_deg_0_180( angle_deg_0_360 <= 0 ) = angle_deg_0_180( angle_deg_0_360 <= 0 ) + 180; 


        % To convert from 0-180 to 0-90 we apply simmetry making taking the
        % suplementary angle for each angle above 90º
        % This configuration meassures the "separation to the vertical"
        angle_deg_0_90 = 90 - abs(angle_deg_0_180 - 90);


        angle_rad_0_pihalf = deg2rad(angle_deg_0_90);

        %Trigonometric functions on the angles in [0 pi]
        Trigonometry.sin_angle_0_90 = sin(angle_rad_0_pihalf);
        Trigonometry.cos_angle_0_90 = cos(angle_rad_0_pihalf);
        Trigonometry.tan_angle_0_90 = tan(angle_rad_0_pihalf);
        Trigonometry.cot_angle_0_90 = cot(angle_rad_0_pihalf);
        Trigonometry.sec_angle_0_90 = sec(angle_rad_0_pihalf);
        Trigonometry.csc_angle_0_90 = csc(angle_rad_0_pihalf);

        %Trigonometric hyperbolic functions on the angles in [0 pi]
        Trigonometry.sinh_angle_0_90 = sinh(angle_rad_0_pihalf);
        Trigonometry.cosh_angle_0_90 = cosh(angle_rad_0_pihalf);
        Trigonometry.tanh_angle_0_90 = tanh(angle_rad_0_pihalf);
        Trigonometry.coth_angle_0_90 = coth(angle_rad_0_pihalf);
        Trigonometry.sech_angle_0_90 = sech(angle_rad_0_pihalf);
        Trigonometry.csch_angle_0_90 = csch(angle_rad_0_pihalf);
        
    else
        
        angle_deg_0_360 = [];
        angle_deg_0_180 = [];
        angle_deg_0_90  = [];
        Trigonometry    = [];
        
    end
    
    
end