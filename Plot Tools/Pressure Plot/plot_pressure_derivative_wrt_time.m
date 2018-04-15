function [ ] = plot_pressure_derivative_wrt_time(Word,plotStyle,MaxVal)
%% plot_pressure_derivative_wrt_time
%  Plots a word struct using a color scale that represents pressure
%
% [  ] = _*plot_pressure_derivative_wrt_time*_ ( _Word_ , _plotStyle_ , _MaxVal_ )
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
        dP_dt_Max = 10; % no units yet
    else
        dP_dt_Max = MaxVal;
    end

    %We compute the derivative w.r.t. time and take its absolute value
    [ dp_dt , ~ , ~ ] = compute_all_pressure_derivatives(Word);
    ModP = abs(dp_dt);

    %Speed on Air is much faster than on ground... Therefore
    %We saturate to a value that allows us to appreciate the
    %different movement speeds on pen down
    ModP(ModP>dP_dt_Max) = dP_dt_Max;
    
    generic_word_plot_in_continuous_color_scale(Word, plotStyle, ModP, dP_dt_Max);
    
    h = colorbar('FontSize',12);
    h.Label.String = strcat('Normalized Pressure Derivative w.r.t Time');
    axis equal
    
end
          