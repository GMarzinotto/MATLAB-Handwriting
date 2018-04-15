function [ jm_norm , jx_norm , jy_norm ] = compute_valid_normalized_jerks(Word)
%% compute_valid_normalized_jerks
%  Computes the valid local jerk values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The jerks computed at the instants T where the tablet
%  losses track of the pen are discarted. Therefore, the indexes in the
%  output vectors may not be directly correlated to the indexes in the Word
%  struct. To ensure the order is kept use compute_all_jerks function
%
% [ _jm_norm_ , _jx_norm_ , _jy_norm_ ] = _*compute_valid_normalized_jerks*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * jm_norm*  : An array containing all the valid local normalized jerk values in word
%                Size of am is Word.NumSamples -3 - 2*(Num_times_track_is_lost)
%
% * jx_norm*  : An array containing all the valid local normalized jerk values in word
%                Size of am is Word.NumSamples -3 - 2*(Num_times_track_is_lost)
%
% * jy_norm*  : An array containing all the valid local normalized jerk values in word
%                Size of am is Word.NumSamples -3 - 2*(Num_times_track_is_lost)
%
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (September 2016)
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

        jx_norm = sqrt((jx.^2).*((dTime3.^5)./(dParamX(1:end-2).^2)));
        jy_norm = sqrt((jy.^2).*((dTime3.^5)./(dParamX(1:end-2).^2)));
        jm_norm = sqrt(jx_norm.^2 + jy_norm.^2);

        %clean values where the track of the pen is lost
        invalid_values = find( isnan(jx_norm) | isinf(jx_norm) | isnan(jy_norm) | isinf(jy_norm) | dTime3 <= 0 )';
        invalid_values = [ invalid_values Word.LostOfTrackPoints (Word.LostOfTrackPoints-1) (Word.LostOfTrackPoints-2) ];
        invalid_values(invalid_values < 1 | invalid_values > length(jx)) = [];
        invalid_values = unique(invalid_values);
        
        jx_norm(invalid_values) = [];
        jy_norm(invalid_values) = [];
        jm_norm(invalid_values) = [];
    
    else
        
        jx_norm = [];
        jy_norm = [];
        jm_norm = [];
        
    end

end