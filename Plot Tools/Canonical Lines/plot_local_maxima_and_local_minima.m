function [] = plot_local_maxima_and_local_minima( Word )
%% plot_local_maxima_and_local_minima
%  Plots a word struct and display its local minima and local maxima.
%  Local minimas and maximas are computed as points of the sequence where
%  the speed value changes sign. Positive => Negative implies local maxima
%  Negative => Positive implies local minima
%
% [  ] = _*plot_local_maxima_and_local_minima*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*          : A Word Struct as defined in this framework 
%                     see wordStruct documentation.  
%
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%

    plot_in_black_and_white(Word,PlotStyle(false,true));
    hold on
    
    [ local_minima , local_maxima ] = compute_local_minima_and_local_maxima( Word , 'ON_TABLET' );
    
    scatter(local_minima.X,local_minima.Y,20,'b','filled');
    scatter(local_maxima.X,local_maxima.Y,20,'r','filled');


end