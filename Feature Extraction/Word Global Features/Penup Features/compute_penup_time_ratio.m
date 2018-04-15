function [penup_ratio] = compute_penup_time_ratio(Word)
%% compute_penup_time_ratio
%  Computes the cocient between time on air and total time used in writing Word.
%
% [ _ratio_ ] = _*compute_penup_time_ratio*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *ratio* : cocient between time on air and total time used in writing Word
% 
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%


    if(~strcmp(Word.Tracking,'ON_TABLET'))
        Word = discard_penup_tracking_information(Word);
    end
    
    total_time = Word.T(end) - Word.T(1);
    penup_time = sum(compute_all_penup_times(Word));
    
    penup_ratio = penup_time/total_time;
    
end