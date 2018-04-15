function [ stroke_length_module, stroke_length_x, stroke_length_y , stroke_length_L1 , stroke_length_Linf , stroke_length_Linfn ] = compute_word_lengths(Word)
%% compute_word_lengths
%  Computes the length of the given word, considers both trajectories
%  ON_TABLET and ON_AIR if the input Word has them
%  Lengths computed include the length of the X projection, 
%  of the Y projection and the module.
%
% [ _stroke_length_module_ , _stroke_length_x_ , _stroke_length_y_  , _stroke_length_L1_ , _stroke_length_Linf_ , _stroke_length_Linfn_ ] = _*compute_word_lengths*_ ( _Word_ )
%
%%% Inputs
% 
% * *Word*  : A Word Struct as defined in this framework 
%             see wordStruct documentation. 
%
%%% Outputs
% 
% * *stroke_length_modules* : Length in cm of the total trajectory of Word module
%
% * *stroke_length_x* : Length in cm of the X projection of the Word trajectory 
%
% * *stroke_length_y* : Length in cm of the Y projection of the Word trajectory 
%
% * *stroke_length_L1* : Length in cm of the total trajectory of Word L1 module
%
% * *stroke_length_Linf* : Length in cm of the total trajectory of Word L-inf module
%
% * *stroke_length_Linfn* : Length in cm of the total trajectory of Word L-inf_neg module
%
%


%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (June 2016)
%  Modified by: ---
%%

   diff_x = diff(Word.X);
   diff_y = diff(Word.Y);
   
   stroke_length_x = 0;
   stroke_length_y = 0;
   stroke_length_module = 0;
   stroke_length_L1 = 0;
   stroke_length_Linf = 0;
   stroke_length_Linfn = 0;
   for k=1:Word.NumSamples-1
       dx=abs(diff_x(k));
       dy=abs(diff_y(k));
       mag=norm([dx dy]);
       stroke_length_x = stroke_length_x + dx;
       stroke_length_y = stroke_length_y + dy;
       stroke_length_module = stroke_length_module + mag;
       stroke_length_L1     = stroke_length_L1 + dx + dy;
       stroke_length_Linf    = stroke_length_Linf + max(dx,dy);
       stroke_length_Linfn    = stroke_length_Linfn + min(dx,dy);
   end
   
end