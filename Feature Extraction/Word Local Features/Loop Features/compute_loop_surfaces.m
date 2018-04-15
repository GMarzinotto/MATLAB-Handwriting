function [ loop_surfaces ] = compute_loop_surfaces(Word, word_type)
%% compute_strokes_lengths
%  Computes the lengths of all the strokes on the word
%  A stroke is segmented under the definition provided in stroke_criterion.
%  Lengths computed include the length of the X projection,
%  of the Y projection and the module.
%
% [ _stroke_lengths_module_ , _stroke_lengths_x_ , _stroke_lengths_y_ ] = _*compute_strokes_lengths*_ ( _Word_ , _word_type_ , _stroke_criterion_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
% * *word_type* : A type to convert the Word Struct into. There are 3 types
%                 ON_TABLET , ON_AIR, ON_TABLET_ON_AIR
%
% * *stroke_criterion* : Stroke Segmentation Criterion, options are:
%                        'PENUP_CRITERION' , 'VY_CRITERION' , 
%                        'VX_CRITERION' , 'VX_VY_CRITERION'
%
%%% Outputs
% 
% * *stroke_length_modules* : List of lengths in cm of the total trajectory of Word module
%
% * *stroke_length_x* : List of lengths in cm of the X projection of the Word trajectory 
%
% * *stroke_length_y* : List of lengths in cm of the Y projection of the Word trajectory 
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    %%INCOMPLETED!!!
    
    iWord = convert_word_to_a_new_tracking_type(Word,word_type);

    data_x = iWord.X;
    data_y = iWord.Y;
    data_t = iWord.T;
    data_p = iWord.P;

    Area = [];

    for k=1:length(data)-2

        while ( k<length(data)-2 ) && ( data_x(k+1) == data_x(k) ) && ( data_y(k+1) == data_y(k) ) 
            k = k + 1;
        end

        if( (data_t(k+1) - data_t(k)<3*Word.SamplePeriod) ...
                && (data_t(k+2) - data_t(k+1)<3*Word.SamplePeriod) ...
                && (data_x(k+1) ~= data_x(k)   || data_y(k+1) ~= data_y(k))...
                && (data_x(k+2) ~= data_x(k+1) || data_y(k+2) ~= data_y(k+1)))

            possibleMatches = [];
            for j=k+2:length(data)-1
                if(data(j+1,4) - data(j,4)<50)
                    possibleMatches = [possibleMatches j];
                else
                    break;
                end
            end

            for j=possibleMatches
                [Cross,CrossPoint]=checkLineCross(data(k,[1,2]),data(k+1,[1,2]),data(j,[1,2]),data(j+1,[1,2]));
                if Cross
                    Area = [Area computeLoopArea(CrossPoint,k,j,data)];
                end
            end
        end
    end

    
    
    Area = unique(round(Area));
    Area(find(Area == 0))=[];
    Area(find(Area == 1))=[];
    
    
end