classdef Lowpass_Filter
   properties
      Number_Of_Coefficients
      Window
      Cut_Frequency
      Lowpass_Filter_Coefficients
   end
   methods
       
       
       function obj = Lowpass_Filter(Number_Of_Coefficients,Window,Cut_Frequency)
            if nargin > 3
                    error('PlotStyle requires at most 3 inputs');
            end
            
            switch nargin
               case 0
                    Number_Of_Coefficients  = 11;
                    Window                  = 'Door';
                    Cut_Frequency           = 0.11; %Normalized Frequency
               case 1
                    Window          =  'Door';
                    Cut_Frequency   = 0.11;  %Normalized Frequency
               case 2
                    Cut_Frequency   = 0.11;  %Normalized Frequency
            end
            
            if (isnumeric(Number_Of_Coefficients) && (mod(Number_Of_Coefficients,2)==1) )
                obj.Number_Of_Coefficients = Number_Of_Coefficients;
            else
                error('Number_Of_Coefficients has to be an even integer!')
            end
            
            
            
            switch Window
               case 'Hamming'
                    window_coeff = hamming(Number_Of_Coefficients);
                    obj.Window = Window;
               case 'Hanning'
                    window_coeff = hanning(Number_Of_Coefficients);
                    obj.Window = Window;
               case 'Triangle'
                    window_coeff = triang(Number_Of_Coefficients);
                    obj.Window = Window;
               case 'Door'
                    window_coeff = ones(Number_Of_Coefficients,1);
                    obj.Window = Window;
                otherwise 
                   error('Invalid Window Name!')
            end
            
            
            if isnumeric(Cut_Frequency)
                obj.Cut_Frequency = Cut_Frequency;
            else
                error('Value Cut_Frequency must be numeric')
            end

            
            support         = [-1*floor(Number_Of_Coefficients/2):1:floor(Number_Of_Coefficients/2)];
            fourierCoef     = Cut_Frequency*sinc(Cut_Frequency*support);
            
            obj.Lowpass_Filter_Coefficients = window_coeff.*fourierCoef';
       end
       
       
       
       function Filtered_data = filter_data(obj,data)
            %Apply the Filter to the data
            Filtered_data = conv(data , obj.Lowpass_Filter_Coefficients,'valid');         
       end
       
       
   end
end