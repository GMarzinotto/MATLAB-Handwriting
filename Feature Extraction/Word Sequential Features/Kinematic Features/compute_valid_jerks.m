function [ jm , jx , jy ] = compute_valid_jerks(Word)
%% compute_valid_jerks
%  Computes the valid local jerk values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The jerks computed at the instants T where the tablet
%  losses track of the pen are discarted. Therefore, the indexes in the
%  output vectors may not be directly correlated to the indexes in the Word
%  struct. To ensure the order is kept use compute_all_jerks function
%
% [ _jm_ , _jx_ , _jy_ ] = _*compute_valid_jerks*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *jm*  : An array containing all the valid local jerk module L2 values in word
%           Size of am is Word.NumSamples -3 - 2*(Num_times_track_is_lost)
%
% * *jx*  : An array containing all the valid local X jerk values in word
%           Size of ax is Word.NumSamples -3 - 2*(Num_times_track_is_lost)
%
% * *jy*  : An array containing all the valid local Y jerk values in word
%           Size of ay is Word.NumSamples -3 - 2*(Num_times_track_is_lost)
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    if( ~isempty(Word) && Word.NumSamples > 3 ) 
        
        %compute all the jerk values
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

        dAX    = diff(ax);
        dAY    = diff(ay);
        dTime3 = diff(Word.T(2:end-1));

        jx = dAX./dTime3;
        jy = dAY./dTime3;

        jm = sqrt(jx.^2 + jy.^2);


        %clean values where the track of the pen is lost
        invalid_values = find( isnan(jx) | isnan(jy));
        invalid_values = [ invalid_values Word.LostOfTrackPoints (Word.LostOfTrackPoints-1) (Word.LostOfTrackPoints-2) ];
        invalid_values(invalid_values < 1 | invalid_values > length(jx)) = [];
        invalid_values = unique(invalid_values);

        jx(invalid_values) = [];
        jy(invalid_values) = [];
        jm(invalid_values) = [];
    
    else
        
        jx = [];
        jy = [];
        jm = [];
        
    end

end