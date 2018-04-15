function [ jm, jx, jy ] = compute_all_jerks(Word)
%% compute_all_jerks
%  Computes all the local jerk values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The jerks computed at the instants T where the tablet
%  losses track of the pen may be invalid. To ensure these values
%  are removed use compute_valid_jerks function
%
% [ _jm_ , _jx_ , _jy_  ] = _*compute_all_jerks*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *jm*  : An array containing all the local jerk module L2 values in word
%           Size of jm is Word.NumSamples -3
%
% * *jx*  : An array containing all the local X jerk values in word
%           Size of jx is Word.NumSamples -3
%
% * *jy*  : An array containing all the local Y jerk values in word
%           Size of jy is Word.NumSamples -3
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

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

end