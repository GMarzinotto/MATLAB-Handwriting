function [ ] = plot_curvature_angle( Word , window_size , plotStyle )
%% plot_curvature_angle
%  Plots a word struct using a color scale that represents curvature
%  
%
% [  ] = _*plot_curvature_angle*_ ( _Word_ , _window_size_ , _plotStyle_ )
%
%%% Inputs
% 
% * *Word*          : A Word Struct as defined in this framework 
%                     see wordStruct documentation. 
%
% * *window_size*   : Window size to compute the curvature
%
% * *plotStyle*     : A PlotStyle object as defined in this framework 
%                     see PlotStyle documentation. 
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin<2)
        window_size = 10;
    end
    
    if(nargin<3)
        plotStyle = PlotStyle();
    end
    
    %Maximum value of curvature angle
    Max_Val = 180; % in degrees


	[ angle_deg_abs ]   = compute_all_curvatures(Word , window_size );

    %Speed on Air is much faster than on ground... Therefore
    %We saturate to a value that allows us to appreciate the
    %different movement speeds on pen down
    angle_deg_abs(angle_deg_abs>Max_Val) = Max_Val;
          
    angle_deg_abs = [ angle_deg_abs(1)*ones(window_size-1,1); angle_deg_abs ; angle_deg_abs(end)*ones(window_size-1,1) ];
    
    newX = zeros(Word.NumSamples-1,1); 
    newY = zeros(Word.NumSamples-1,1);
    newP = zeros(Word.NumSamples-1,1);
    newT = zeros(Word.NumSamples-1,1);
    
    newX(1) = Word.X(1);   newX(end) = Word.X(end);
    newY(1) = Word.Y(1);   newY(end) = Word.Y(end);
    newP(1) = Word.P(1);   newP(end) = Word.P(end);
    newT(1) = Word.T(1);   newT(end) = Word.T(end);
    
    for k=2:Word.NumSamples-2
        if( (~any(k == Word.LostOfTrackPoints)) && (( Word.P(k) == 0 && Word.P(k+1) == 0 ) || ( Word.P(k) > 0 && Word.P(k+1) > 0 ) ))
            newX(k) = (Word.X(k) + Word.X(k+1))/2;
            newY(k) = (Word.Y(k) + Word.Y(k+1))/2;
            newP(k) = (Word.P(k) + Word.P(k+1))/2;
            newT(k) = (Word.T(k) + Word.T(k+1))/2;
        else
            newX(k) = Word.X(k);
            newY(k) = Word.Y(k);
            newP(k) = Word.P(k);
            newT(k) = Word.T(k);
        end
    end
    
    
    Word.X = newX;
    Word.Y = newY;
    Word.P = newP;
    Word.T = newT;
    Word.NumSamples = Word.NumSamples - 1;
    
    %Plot Everything
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, angle_deg_abs, Max_Val);
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('Curvature (degrees)');
    axis equal
    
end