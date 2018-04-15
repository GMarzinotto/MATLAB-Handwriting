classdef PlotStyle
   properties
      plotOnAir
      plotOnTablet
      lineWidthPenDown
      lineWidthPenUp
      jetColor
      discreteColors
      display_tags
   end
   methods
       function obj = PlotStyle(plotOnAir,plotOnTablet,lineWidthPenDown,lineWidthPenUp,jetColor,discreteColors,display_tags)
            if nargin > 7
                    error('PlotStyle requires at most 7 inputs');
            end
            switch nargin
               case 0
                    plotOnAir        = true;
                    plotOnTablet     = true;
                    lineWidthPenDown = 2;
                    lineWidthPenUp   = 0.01;
                    jetColor         = 64;
                    discreteColors   = 2;
                    display_tags     = false;
               case 1
                    plotOnTablet     = true;
                    lineWidthPenDown = 2;
                    lineWidthPenUp   = 0.01;
                    jetColor         = 64;
                    discreteColors   = 2;
                    display_tags     = false;
               case 2
                    lineWidthPenDown = 2;
                    lineWidthPenUp   = 0.01;
                    jetColor         = 64;
                    discreteColors   = 2;
                    display_tags     = false;
               case 3
                    lineWidthPenUp   = 0.01;
                    jetColor         = 64;
                    discreteColors   = 2;
                    display_tags     = false;
                case 4
                    jetColor         = 64;
                    discreteColors   = 10;
                    display_tags     = false;
                case 5
                    discreteColors   = 2;
                    display_tags     = false;
                case 6
                    display_tags     = false;
            end
            if islogical(plotOnAir)
                obj.plotOnAir = plotOnAir;
            else
                error('Value plotOnAir must be boolean')
            end
            if islogical(plotOnTablet)
                obj.plotOnTablet = plotOnTablet;
            else
                error('Value plotOnTablet must be boolean')
            end
            if isnumeric(lineWidthPenDown)
                obj.lineWidthPenDown = lineWidthPenDown;
            else
                error('Value lineWidthPenDown must be numeric')
            end
            if isnumeric(lineWidthPenUp)
                obj.lineWidthPenUp = lineWidthPenUp;
            else
                error('Value lineWidthPenUp must be numeric')
            end
            if isnumeric(jetColor)
                obj.jetColor = jetColor;
            else
                error('Value jetcolor must be numeric')
            end
            if isnumeric(discreteColors)
                obj.discreteColors = discreteColors;
            else
                error('Value discreteColors must be numeric')
            end
            if islogical(display_tags)
                obj.display_tags = display_tags;
            else
                error('Value display_tags must be boolean')
            end
       end
   end
end