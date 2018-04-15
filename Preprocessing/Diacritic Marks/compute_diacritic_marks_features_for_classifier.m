function [ features , feature_names , struct_features ] = compute_diacritic_marks_features_for_classifier( Segment , Canonical_Lines )
%% compute_diacritic_marks_features_for_classifier
%  Computes the feature set used to classify a stroke as a punctuation mark
%  using the SVM model. These features are:
%  - Stroke Length in X , Y , L2
%  - Histogram of distribution of points among the canonical lines  
%                       
%
% [ _features_ , _feature_names_ , _struct_features_ ] = _*compute_diacritic_marks_features_for_classifier*_ ( _Segment_ , _Canonical_Lines_ )
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


    %%Distribution of points w.r.t canonical lines       
    Strokes_Canonical_Lines_Dist = compute_word_point_dist_hist_wrt_canonical_lines( Segment , 'ON_TABLET' , Canonical_Lines );
    Strokes_Canonical_Lines_Dist = rmfield(Strokes_Canonical_Lines_Dist,'mid');
    
        
    %%Current strokes lengths
    [ ~ , stroke_length_x, stroke_length_y , ~ , ~ , ~ ] = compute_word_lengths( Segment );
    
    Current_Stroke_Length.Xabs  = stroke_length_x;
    Current_Stroke_Length.Yabs  = stroke_length_y; 
        
    %%Inclination
    Inclination = compute_inclination_unidimensional_statistics( Segment , 'ON_TABLET' );
    
    
    %%Merge Features Into One Struct
    struct_features.Current_Stroke_Length           = Current_Stroke_Length;
    struct_features.Strokes_Canonical_Lines_Dist    = Strokes_Canonical_Lines_Dist;
    struct_features.Inclin_avg                      = Inclination.angle_0_180.mean;
    
    [ features , feature_names ] = get_features_from_struct( struct_features , 'Features' ); 

    
end