function [ penup_x_distances ] = compute_horizontal_penup_spacing( Word )
%% compute_horizontal_penup_spacing
%  Computes all the distances between penups in the X axis using an online
%  Approach. Positive values correspond to displacements to the right in
%  the X axis. Negative values correspond to displacements to the left.
%
% [ _penup_fequency_ ] = _*compute_horizontal_penup_spacing*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *penup_x_distances* : cocient between time on air and total time used in writing Word
% 
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%


    if(~strcmp(Word.Tracking,'ON_TABLET'))
        Word = discard_penup_tracking_information(Word);
    end
    
    penup_x_distances  = Word.X(Word.LostOfTrackPoints + 1) - Word.X(Word.LostOfTrackPoints);

end