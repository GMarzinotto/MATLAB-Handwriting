function [ am, ax, ay ] = compute_all_accelerations(Word)
%% compute_all_accelerations
%  Computes all the local acceleration values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The acceleration computed at the instants T where the tablet
%  losses track of the pen may be invalid. To ensure these values
%  are removed use compute_valid_accelerations function
%
% [ _am_ , _ax_ , _ay_  ] = _*compute_all_accelerations*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *am*  : An array containing all the local acceleration module L2 values in word
%           Size of am is Word.NumSamples -2
%
% * *ax*  : An array containing all the local X acceleration values in word
%           Size of ax is Word.NumSamples -2
%
% * *ay*  : An array containing all the local Y acceleration values in word
%           Size of ay is Word.NumSamples -2
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
    
    am = sqrt(ax.^2 + ay.^2);

end