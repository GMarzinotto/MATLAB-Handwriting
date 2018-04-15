function [ am , ax , ay ] = compute_valid_accelerations(Word)
%% compute_valid_accelerations
%  Computes the valid local acceleration values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The accelerations computed at the instants T where the tablet
%  losses track of the pen are discarted. Therefore, the indexes in the
%  output vectors may not be directly correlated to the indexes in the Word
%  struct. To ensure the order is kept use compute_all_accelerations function
%
% [ _am_ , _ax_ , _ay_ ] = _*compute_valid_accelerations*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *am*  : An array containing all the valid local acceleration module L2 values in word
%           Size of am is Word.NumSamples -2 - 2*(Num_times_track_is_lost)
%
% * *ax*  : An array containing all the valid local X acceleration values in word
%           Size of ax is Word.NumSamples -2 - 2*(Num_times_track_is_lost)
%
% * *ay*  : An array containing all the valid local Y acceleration values in word
%           Size of ay is Word.NumSamples -2 - 2*(Num_times_track_is_lost)
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    if( ~isempty(Word) && Word.NumSamples > 2 ) 
        
        %compute all the acceleration values
        dParamX = diff(Word.X);
        dParamY = diff(Word.Y);
        dTime   = diff(Word.T);

        vx = dParamX./dTime;
        vy = dParamY./dTime;


        dVX    = diff(vx);
        dVY    = diff(vy);
        dTime2 = (Word.T(3:end) - Word.T(1:end-2))/2;


        ax = dVX./dTime2;
        ay = dVY./dTime2;
        am = sqrt(ax.^2 + ay.^2);


        %clean values where the track of the pen is lost
        invalid_values = find( isnan(ax) | isnan(ay));
        invalid_values = [ invalid_values Word.LostOfTrackPoints (Word.LostOfTrackPoints-1) ];
        invalid_values(invalid_values < 1 | invalid_values > length(ax) ) = [];
        invalid_values = unique(invalid_values);

        ax(invalid_values) = [];
        ay(invalid_values) = [];
        am(invalid_values) = [];
        
    else
        
        am = [];
        ax = [];
        ay = [];
    
    end

end