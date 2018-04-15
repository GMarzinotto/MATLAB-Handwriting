function [ features , feature_names , struct_features ] = compute_delayed_strokes_features_for_classifier( Word , previous_stroke , current_stroke , next_stroke )
%% compute_delayed_strokes_features_for_classifier
%  Computes the feature set used to classify a stroke as a punctuation mark
%  using the SVM model. These features are:
%  - Stroke Length in X , Y , L2
%  - Histogram of distribution of points among the canonical lines  
%                       
%
% [ _features_ , _feature_names_ , _struct_features_ ] = _*compute_delayed_strokes_features_for_classifier*_ ( _Segment_ , _Canonical_Lines_ )
%
%%% Inputs
% 
% * *Segment*      : A Word Struct as defined in this framework 
%                    see wordStruct documentation. Contains a segment  
%                    to be classified   
%
% * *Canonical_Lines* : A struct containing the canonical lines that will
%                       be used as bin delimiters, if it is not provided 
%                       It computes the canonical lines using the segment
%                      
%
%%% Outputs
%
% * *features*  : A feature vector with the features described above
%
% * *feature_names* : The names of the features stored in a cell array
%
% * *struct_features* : A struct containing the features in a hierarchical
%                       pattern
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (August 2016)
%  Modified by: ---
%%
    
    resampled_prev_stroke   = resample_word( previous_stroke );
    resampled_curr_stroke   = resample_word( current_stroke );
    resampled_next_stroke   = resample_word( next_stroke );
    
    %% Distribution of points w.r.t canonical lines 
        
    prev_str_line = get_text_line_containing_stroke( Word , previous_stroke );
    prev_str_hist = compute_word_point_dist_hist_wrt_canonical_lines( prev_str_line , 'ON_TABLET' ); %, resampled_prev_stroke );

    curr_str_line = get_text_line_containing_stroke( Word , current_stroke  );
    curr_str_hist = compute_word_point_dist_hist_wrt_canonical_lines( curr_str_line , 'ON_TABLET' ); %,  resampled_curr_stroke );
    
    next_str_line = get_text_line_containing_stroke( Word , next_stroke     );
    next_str_hist = compute_word_point_dist_hist_wrt_canonical_lines( next_str_line , 'ON_TABLET' ); %, resampled_next_stroke );
    
    Strokes_Canonical_Lines_Dist.prev_str_hist = prev_str_hist;
    Strokes_Canonical_Lines_Dist.curr_str_hist = curr_str_hist;
    Strokes_Canonical_Lines_Dist.next_str_hist = next_str_hist;
    
    
    %% Curvature and Inclination
    
    Inc = compute_inclination_unidimensional_histograms( resampled_prev_stroke , 'ON_TABLET' , 8 , 'Quantification' , 'Basic' );
    Inclination.prev_str = Inc.angle_0_180;
    Inc = compute_inclination_unidimensional_histograms( resampled_curr_stroke , 'ON_TABLET' , 8 , 'Quantification' , 'Basic' );
    Inclination.curr_str = Inc.angle_0_180;
    Inc = compute_inclination_unidimensional_histograms( resampled_next_stroke , 'ON_TABLET' , 8 , 'Quantification' , 'Basic' );
    Inclination.next_str = Inc.angle_0_180;
    
    Curvature.prev_str   = compute_curvature_unidimensional_histograms( resampled_prev_stroke , 'ON_TABLET' , 4 , 8 , 'Quantification' , 'Basic' );
    Curvature.curr_str   = compute_curvature_unidimensional_histograms( resampled_curr_stroke , 'ON_TABLET' , 4 , 8 , 'Quantification' , 'Basic' );
    Curvature.next_str   = compute_curvature_unidimensional_histograms( resampled_next_stroke , 'ON_TABLET' , 4 , 8 , 'Quantification' , 'Basic' );
    
    
    %% Features for spacing w.r.t the previous stroke
    x_previous_step = current_stroke.X(1) - previous_stroke.X(end);
    y_previous_step = current_stroke.Y(1) - previous_stroke.Y(end);
    
    [norm_l2 , ~ , ~ , ~ , ~ , ~ ] = compute_all_norms( x_previous_step , y_previous_step );
    
    Previous_Step.L2    = norm_l2;
    Previous_Step.X     = x_previous_step;
    Previous_Step.Y     = y_previous_step;
    
    %% Features for spacing w.r.t the next stroke
    x_next_step = next_stroke.X(1) - current_stroke.X(end);
    y_next_step = next_stroke.Y(1) - current_stroke.Y(end);
    
    [norm_l2 , ~ , ~ , ~ , ~ , ~ ] = compute_all_norms( x_next_step , y_next_step );
    
    Next_Step.L2    = norm_l2;
    Next_Step.X     = x_previous_step;
    Next_Step.Y     = y_previous_step;
    
    
    
    %% Previous strokes lengths
    [ stroke_length_L2 , stroke_length_x, stroke_length_y , ~ , ~ , ~ ] = compute_word_lengths(previous_stroke);
    
    Previous_Stroke_Length.L2    = stroke_length_L2;
    Previous_Stroke_Length.Xabs  = stroke_length_x;
    Previous_Stroke_Length.Yabs  = stroke_length_y;
    
    %% Current strokes lengths
    [ stroke_length_L2 , stroke_length_x, stroke_length_y , ~ , ~ , ~ ] = compute_word_lengths(current_stroke);
    
    Current_Stroke_Length.L2    = stroke_length_L2;
    Current_Stroke_Length.Xabs  = stroke_length_x;
    Current_Stroke_Length.Yabs  = stroke_length_y; 
    
    
    %% Next strokes lengths
    [ stroke_length_L2 , stroke_length_x, stroke_length_y , ~ , ~ , ~ ] = compute_word_lengths(next_stroke);
    
    Next_Stroke_Length.L2    = stroke_length_L2;
    Next_Stroke_Length.Xabs  = stroke_length_x;
    Next_Stroke_Length.Yabs  = stroke_length_y; 
    
    
    
    
    
    %% Merge Features Into One Struct

    struct_features.Previous_Step                   = Previous_Step;
    struct_features.Next_Step                       = Next_Step;
    struct_features.Previous_Stroke_Length          = Previous_Stroke_Length;
    struct_features.Current_Stroke_Length           = Current_Stroke_Length;
    struct_features.Next_Stroke_Length              = Next_Stroke_Length;
    struct_features.Strokes_Canonical_Lines_Dist    = Strokes_Canonical_Lines_Dist;
    struct_features.Inclination                     = Inclination;
    struct_features.Curvature                       = Curvature;
    
    [ features , feature_names ] = get_features_from_struct( struct_features , 'Features' ); 

    
end