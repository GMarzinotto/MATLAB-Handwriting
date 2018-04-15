function [norm_l2 , norm_l1 , norm_linf , norm_linfn, abs_x , abs_y ] = compute_all_norms(comp_x , comp_y)
%% compute_all_norms
%  Computes all the norms using the comp_x and comp_y inputs
%  This function may be used to compute position, speed, acceleration,
%  jerk, etc... norms
%
% [ _norm_l2_ , _norm_l1_ , _norm_linf_ , _abs_x_ , _abs_y _ ] = _*compute_all_norms*_ ( _comp_x_ , _comp_y_ )
%
%%% Inputs
% 
% * *comp_x*      : Avector of x components, could be position, speed, etc...
%
% * *comp_y*      : Avector of y components, could be position, speed, etc...
%
%%% Outputs
% 
% * *norm_l2*  : An array containing the L2 norm of (comp_x,comp_y)
%
% * *norm_l1*  : An array containing the L1 norm of (comp_x,comp_y)
%
% * *norm_linf*  : An array containing the Linf norm of (comp_x,comp_y)
%
% * *norm_linfn*  : An array containing the L-inf norm of (comp_x,comp_y)
%
% * *abs_x* : An array containing the absolute value of comp_y
%
% * *abs_y* : An array containing the absolute value of comp_y
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    abs_x     = abs(comp_x);
    abs_y     = abs(comp_y);
    norm_l2   = sqrt(comp_x.^2 + comp_y.^2);
    norm_l1   = abs_x + abs_y;
    norm_linf = max(abs_x,abs_y);
    norm_linfn = min(abs_x,abs_y);

end