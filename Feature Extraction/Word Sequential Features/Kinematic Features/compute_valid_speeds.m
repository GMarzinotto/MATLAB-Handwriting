function [ vm , vx , vy ] = compute_valid_speeds( Word )
%% compute_valid_speeds
%  Computes the valid local speeds values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The speeds computed at the instants T where the tablet
%  losses track of the pen are discarted. Therefore, the indexes in the
%  output vectors may not be directly correlated to the indexes in the Word
%  struct. To ensure the order is kept use compute_all_speeds functions
%
% [ _vm_ , _vx_ , _vy_ ] = _*compute_valid_speeds*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *vm*  : An array containing all the valid local speed module L2 values in word
%               Size of vm is Word.NumSamples -1 -(Num_times_track_is_lost)
%
% * *vx*  : An array containing all the valid local X speed values in word
%               Size of vx is Word.NumSamples -1 -(Num_times_track_is_lost)
%
% * *vy*  : An array containing all the valid local Y speed values in word
%               Size of vy is Word.NumSamples -1 -(Num_times_track_is_lost)
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    if( ~isempty(Word) && Word.NumSamples > 1 ) 

        %compute all the speed values
        dParamX = diff(Word.X);
        dParamY = diff(Word.Y);
        dTime   = diff(Word.T);

        vx = dParamX./dTime;
        vy = dParamY./dTime;
        vm = sqrt(vx.^2 + vy.^2);

        %clean values where the track of the pen is lost
        invalid_values = Word.LostOfTrackPoints;
        invalid_values(invalid_values < 1 | invalid_values > length(vx)) = [];

        vx(invalid_values) = [];
        vy(invalid_values) = []; 
        vm(invalid_values) = [];

    else
        
        vx = [];
        vy = []; 
        vm = [];
        
    end

end