function [ vm , vx , vy ] = compute_all_speeds(Word)
%% compute_all_speeds
%  Computes all the local speeds values in a word struct
%  Considers Trajectories on tablet and on air (if registered)
%  Waring: The speeds computed at the instants T where the tablet
%  losses track of the pen may be invalid. To ensure these values
%  are removed use compute_valid_speeds function
%
% [ _vm_ , _vx_ , _vy_  ] = _*compute_all_speeds*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
%%% Outputs
% 
% * *vm*  : An array containing all the local speed module L2 values in word
%           Size of vm is Word.NumSamples -1
%
% * *vx*  : An array containing all the local X speed values in word
%           Size of vx is Word.NumSamples -1
%
% * *vy*  : An array containing all the local Y speed values in word
%           Size of vy is Word.NumSamples -1
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
    
    vx = dParamX./dTime;
    vy = dParamY./dTime;
    vm = sqrt(vx.^2 + vy.^2);


end