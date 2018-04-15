function [ ] = plot_acceleration_y(Word,plotStyle,MaxVal)
%% plot_acceleration_y
%  Plots a word struct using a color scale that represents Y acceleration
%
% [  ] = _*plot_acceleration_y*_ ( _Word_ , _plotStyle_ , _MaxVal_ )
%
%%% Inputs
% 
% * *Word*      : A Word Struct as defined in this framework 
%                 see wordStruct documentation. 
%
% * *plotStyle*  : A PlotStyle object as defined in this framework 
%                  see PlotStyle documentation. 
%
% * *MaxVal*    : Maximum Value to saturate Colobar  
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (April 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin<2)
        plotStyle = PlotStyle();
    end
    
    %Maximum value of Acceleration in the parameters
    %Larger values will be saturated to AMax
    if(nargin<3)
        AMax = 200; % in cm/s^2
    else
        AMax = MaxVal;
    end


	[ ~ , ~ , ay ]   = compute_all_accelerations(Word);
    ModA = abs(ay);

    %Speed on Air is much faster than on ground... Therefore
    %We saturate to a value that allows us to appreciate the
    %different movement speeds on pen down
    ModA(ModA>AMax) = AMax;
            
    newX = zeros(Word.NumSamples-1,1); 
    newY = zeros(Word.NumSamples-1,1);
    newP = zeros(Word.NumSamples-1,1);
    newT = zeros(Word.NumSamples-1,1);
    
        
    newX(1) = Word.X(1);   newX(end) = Word.X(end);
    newY(1) = Word.Y(1);   newY(end) = Word.Y(end);
    newP(1) = Word.P(1);   newP(end) = Word.P(end);
    newT(1) = Word.T(1);   newT(end) = Word.T(end);
    
    for k=1:Word.NumSamples-2
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
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, ModA, AMax);
    
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('Y Acceleration (cm/s^2)');
    axis equal
    
end