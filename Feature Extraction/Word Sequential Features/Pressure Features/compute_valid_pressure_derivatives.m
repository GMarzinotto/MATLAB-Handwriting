function [ dp_dt , dp_dx , dp_dy ] = compute_valid_pressure_derivatives(Word)
%% compute_valid_pressure_derivatives
%  Computes all the pressure derivetive values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  the derivatives compute are w.r.t time, x position and y position
%  Waring: The speeds computed at the instants T where the tablet
%  losses track of the pen are discarted. Therefore, the indexes in the
%  output vectors may not be directly correlated to the indexes in the Word
%  struct. To ensure the order is kept use compute_all_pressure_derivatives
%
% [ _dp_dt_ , _dp_dx_ , _dp_dy_  ] = _*compute_valid_pressure_derivatives*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *dp_dt*  : An array containing all the presure derivatives w.r.t time
%                  Size of dp_dt is Word.NumSamples -1
%
% * *dp_dx*  : An array containing all the presure derivatives w.r.t X
%                  Size of dp_dx is Word.NumSamples -1
%
% * *dp_dy*  : An array containing all the presure derivatives w.r.t Y
%                  Size of dp_dy is Word.NumSamples -1
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    %compute all the speed values
	dParamX = diff(Word.X);
    dParamY = diff(Word.Y);
    dTime   = diff(Word.T);
    dPress  = diff(Word.P);
    
    dp_dt = dPress./dTime;
    dp_dx = dPress./dParamX;
    dp_dy = dPress./dParamY;
    
    %clean values where the track of the pen is lost
    invalid_values = Word.LostOfTrackPoints;
    invalid_values(invalid_values < 1 | invalid_values > length(dp_dt)) = [];
    
    
    
    dp_dt(invalid_values) = [];
    dp_dx(invalid_values) = [];
    dp_dy(invalid_values) = [];
    
    dp_dt(isinf(dp_dt) | isnan(dp_dt)) = [];
    
    inf_and_nans = isinf(dp_dx) | isnan(dp_dx) | isinf(dp_dy) | isnan(dp_dy);
    dp_dx(inf_and_nans) = [];
    dp_dy(inf_and_nans) = [];

end