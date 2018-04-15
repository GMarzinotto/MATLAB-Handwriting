function [ ] = plot_pressure_derivative_wrt_xy(Word,plotStyle,MaxVal)
%% plot_pressure_derivative_wrt_xy
%  Plots a word struct using a color scale that represents pressure
%  derivative w.r.t x and y coordinates
%
% [  ] = _*plot_pressure_derivative_wrt_xy*_ ( _Word_ , _plotStyle_ , _MaxVal_ )
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
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    %If no style is provided use default
    if(nargin<2)
        plotStyle = PlotStyle();
    end
    
    %Maximum value of Pressure Derivative in the parameters
    %Larger values will be saturated to AMax
    if(nargin<3)
        dPMax = 10; % no units yet
    else
        dPMax = MaxVal;
    end

    

    %We copy the Pressure value to apply saturation
    %At this point saturation is not needed for the Pressure
    %But in the future it might/will be
    [ ~ , dp_dx , dp_dy ] = compute_all_pressure_derivatives(Word);
    ModP = sqrt(dp_dx.^2 + dp_dy.^2);


    %We saturate to a value that allows us to appreciate better the scale
    ModP(ModP>dPMax) = dPMax;
    
    %Call to the generic plotter function
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, ModP, dPMax);
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('Normalized Pressure Derivative w.r.t XY');
    axis equal
    
end
          