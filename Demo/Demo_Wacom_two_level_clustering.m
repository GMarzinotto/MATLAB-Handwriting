clear all;
close all;
clc;

%Read Files and Feature Extraction
[BASEPATH ,name,ext] = fileparts( mfilename('fullpath')  );
mainPath = strcat(BASEPATH,'\Demo Database\Wacom');

files = dir(mainPath);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
subFolders(1:2) = [];
All_Words = [];
Writers = [];
Writers_Ages = [];
Writers_Labels = [];
labels_words = [];
all_features_words = [];
extended_all_features_words = [];

%Loop for each person
for i = 1 : length(subFolders)
    %Loop for each Word
    personID = subFolders(i).name;
    filePath = strcat(mainPath,'\',personID);
    iWriter  = read_full_person_wacom_app(filePath);
    age_klabel     = iWriter.Metadata.Writer_Age;
    klabel         = randi(3); %get_label_stage(iWriter);
    
    if(~isnan(klabel))
        for j=1:2
            if (isfield(iWriter,strcat('Test',num2str(j))))

                jTest = eval(strcat('iWriter.Test',num2str(j)));

                [ kwordList ] = segment_by_words( jTest );
                nwords = length(kwordList);

                for l=1:nwords

                    lword 			= recalibrate_word(kwordList(l));
                    lword.Writer_ID = iWriter.Metadata.Writer_ID;

                    %Dinamic Feature Extraction On Tablet
                    Speed_Tablet            = compute_speed_unidimensional_histograms(lword, 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );  
                    Acceleration_Tablet     = compute_acceleration_unidimensional_histograms(lword, 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );
                    Jerk_Tablet             = compute_jerk_unidimensional_histograms(lword, 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );
                    Normalized_Jerk_Tablet  = compute_normalized_jerk_unidimensional_histograms( lword , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

                    %Dinamic Feature Extraction On Air
                    Speed_Air               = compute_speed_unidimensional_statistics(lword,'ON_AIR' );  
                    Acceleration_Air        = compute_acceleration_unidimensional_statistics(lword,'ON_AIR');
                    Jerk_Air                = compute_jerk_unidimensional_statistics(lword,'ON_AIR');
                    Normalized_Jerk_Air     = compute_normalized_jerk_unidimensional_statistics( lword , 'ON_AIR');


                    %Penup Feature Extraction
                    penup_ratio  	= compute_penup_time_ratio(lword);
                    penup_fequency 	= compute_number_of_penups(lword);
                    Penups_Hist     = compute_penup_time_unidimensional_statistics( lword );


                    %Pressure Feature Extraction
                    Pressure               = compute_pressure_unidimensional_histograms(lword,'ON_TABLET', 4 , 'Quantification' , 'Basic');
                    Pressure_T_Derivative  = compute_pressure_derivative_wrt_time_unidimensional_histograms( lword,'ON_TABLET', 4 , 'Quantification' , 'Basic' );
                    Pressure_XY_Derivative = compute_pressure_derivative_wrt_xy_unidimensional_histograms( lword , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

                    
                    %Penup Stroke Feature Extraction On Tablet
                    Penup_Stroke_Length_Tablet 	= compute_stroke_length_unidimensional_statistics( lword , 'ON_TABLET' , 'PENUP_CRITERION' );
                    Stroke_Length_Tablet_X      = compute_stroke_length_unidimensional_statistics( lword , 'ON_TABLET' , 'VY_CRITERION'    );
                    Stroke_Length_Tablet_Y      = compute_stroke_length_unidimensional_statistics( lword , 'ON_TABLET' , 'VX_CRITERION'    );
                    Stroke_Length_Tablet_XY     = compute_stroke_length_unidimensional_statistics( lword , 'ON_TABLET' , 'VX_VY_CRITERION' );
                    %Penup Stroke Feature Extraction On Air
                    Penup_Stroke_Length_Air 	= compute_stroke_length_unidimensional_statistics( lword , 'ON_AIR' , 'PENUP_CRITERION' );
                    Stroke_Length_Air_X 		= compute_stroke_length_unidimensional_statistics( lword , 'ON_AIR' , 'VY_CRITERION'    );
                    Stroke_Length_Air_Y 		= compute_stroke_length_unidimensional_statistics( lword , 'ON_AIR' , 'VX_CRITERION'    );
                    Stroke_Length_Air_XY 		= compute_stroke_length_unidimensional_statistics( lword , 'ON_AIR' , 'VX_VY_CRITERION' );
                    
                    
                    %Pen Angle Feature Extraction On Tablet
                    Altitude_Angle_Tablet  	= compute_altitude_angle_unidimensional_histograms( lword , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );
                    Azimuth_Angle_Tablet 	= compute_azimuth_angle_unidimensional_histograms( lword  , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );
                    %Pen Angle Feature Extraction On Air
                    Altitude_Angle_Air  = compute_altitude_angle_unidimensional_statistics( lword , 'ON_AIR' );
                    Azimuth_Angle_Air 	= compute_azimuth_angle_unidimensional_statistics( lword  , 'ON_AIR' );

                    
                    %Size Features
                    [ ~ , ~ , ~ , ~ , ~ , Canonical_Lines ] = compute_canonical_lines_height_estimates_with_local_min_max( lword , 0 , true );
                    avg_corpus_size = compute_corpus_size( lword , Canonical_Lines );
                    avg_upper_ext   = compute_upper_extension_size( lword , Canonical_Lines );
                    avg_lower_ext   = compute_lower_extension_size( lword , Canonical_Lines );
    
                    
                    %Grouping Features
                    BL_Grouping  = compute_baseline_grouping_unidimensional_statistics(   lword , Canonical_Lines.BaseLine  );
                    ML_Grouping  = compute_medianline_grouping_unidimensional_statistics( lword , Canonical_Lines.MedianLine  );
                    UL_Grouping  = compute_upperline_grouping_unidimensional_statistics(  lword , Canonical_Lines.UpperLine  );

                    %Resample Word 
                    [resampled_kline_segment] = resample_word( lword );

                    %Spatial Feature Extraction On Tablet
                    Inclinations_Tablet = compute_inclination_unidimensional_histograms(lword,'ON_TABLET', 8 , 'Quantification' , 'Basic');
                    Curvatures_Tablet   = compute_curvature_unidimensional_histograms(lword  ,'ON_TABLET', 10 , 8 , 'Quantification' , 'Basic');
                    %Spatial Feature Extraction On Air
                    Inclinations_Air    = compute_inclination_unidimensional_statistics(lword,'ON_AIR' );
                    Curvatures_Air      = compute_curvature_unidimensional_statistics( lword , 'ON_AIR' , 10 );


                    %Spacing Features Full Word
                    Box_Spacing   = compute_horizontal_box_spacing_unidimensional_statistics( lword );
                    ConvexHull_Spacing = compute_horizontal_convexhull_spacing_unidimensional_statistics( lword );
                    MedianLine_Spacing = compute_horizontal_medianline_spacing_unidimensional_statistics( lword );
                    Penup_Spacing = compute_horizontal_penup_spacing_unidimensional_statistics( lword );

    

                    %Put all the features into a single object 
                    WFeatures.Speed_Tablet        = Speed_Tablet.L2;    
                    WFeatures.Acceleration_Tablet = Acceleration_Tablet.L2;   
                    WFeatures.Jerk_Tablet         = Jerk_Tablet.L2;  
                    WFeatures.Jerk_Norm_Tablet    = Normalized_Jerk_Tablet.L2;
                    WFeatures.Speed_Air           = Speed_Air.L2.mean;    
                    WFeatures.Acceleration_Air    = Acceleration_Air.L2.mean;   
                    WFeatures.Jerk_Air            = Jerk_Air.L2.mean;  
                    WFeatures.Jerk_Norm_Air       = Normalized_Jerk_Air.L2.mean;
                    
                    WFeatures.Inclinations_Tablet = Inclinations_Tablet.angle_0_180;
                    WFeatures.Curvatures_Tablet   = Curvatures_Tablet.angle_0_180;
                    WFeatures.Inclinations_Air    = Inclinations_Air.angle_0_180.mean;
                    WFeatures.Curvatures_Air      = Curvatures_Air.angle_0_180.mean;
                    
                    WFeatures.Pressure            = Pressure;
                    WFeatures.Pressure_T_Deriv    = Pressure_T_Derivative;
                    WFeatures.Pressure_XY_Deriv   = Pressure_XY_Derivative.L2;
                    
                    WFeatures.Penup_Ratio         = penup_ratio;
                    WFeatures.Penup_Frequency     = penup_fequency;
                    WFeatures.Penup_Times         = Penups_Hist.mean;
                    
                    WFeatures.PStroke_L2Len_Tab    = Penup_Stroke_Length_Tablet.L2.mean;
                    WFeatures.XStroke_L2Len_Tab    = Stroke_Length_Tablet_X.L2.mean;
                    WFeatures.YStroke_L2Len_Tab    = Stroke_Length_Tablet_Y.L2.mean;
                    WFeatures.XYStroke_L2Len_Tab   = Stroke_Length_Tablet_XY.L2.mean;
                    
                    WFeatures.PStroke_L2Len_Air    = Penup_Stroke_Length_Air.L2.mean;
                    WFeatures.XStroke_L2Len_Air    = Stroke_Length_Air_X.L2.mean;
                    WFeatures.YStroke_L2Len_Air    = Stroke_Length_Air_Y.L2.mean;
                    WFeatures.XYStroke_L2Len_Air   = Stroke_Length_Air_XY.L2.mean;     
                    
                    WFeatures.BL_Grouping         = BL_Grouping.mean;
                    WFeatures.ML_Grouping         = ML_Grouping.mean;
                    WFeatures.UL_Grouping         = UL_Grouping.mean;
                    
                    
                    WFeatures.Alt_Ang_Tablet      = Altitude_Angle_Tablet;

                    
                    WFeatures.Corpus_Size         = avg_corpus_size;
                    WFeatures.Upper_Size          = avg_upper_ext;
                    WFeatures.Lower_Size          = avg_lower_ext;
                    
                    
                    WFeatures.Box_Spacing         = Box_Spacing.mean;
                    WFeatures.Convex_Spacing      = ConvexHull_Spacing.mean;
                    WFeatures.MedianLine_Spacing  = MedianLine_Spacing.mean;
                    WFeatures.Penup_Spacing       = Penup_Spacing.mean;
                    

                    [ lFeatures , features_names_layer1 ] = get_features_from_struct( WFeatures , 'F' ); 
                    all_features_words = [all_features_words; lFeatures];  
                    
                    
                    All_Words = [ All_Words; lword ];                     
                    labels_words  = [labels_words; klabel];
                    Writers_Ages = [Writers_Ages; age_klabel];  

                end
            end
        end
    end
    
      Writers = [Writers; iWriter];
      Writers_Labels = [Writers_Labels; klabel]  ;

end



all_features_words_no_nan = replace_NaN_with_person_average( all_features_words , {All_Words.Writer_ID} );

for feat=1:length(features_names_layer1)
   invalid_indexes = find( isnan(all_features_words_no_nan(:,feat)) );
   all_features_words_no_nan(invalid_indexes,feat) = nanmean( all_features_words_no_nan(:,feat) ); 
end



%Centre and Z-Normalization
all_features_words_znorm = zscore(all_features_words_no_nan);


label_names = { 'Class1' , 'Class2' , 'Class3' };
             


%Feature Selection 
[ inmodel_layer1 , ~ ] = feature_selection_with_interclass_inertia_for_classification( all_features_words_znorm , labels_words , 15 );

all_features_words_znorm = all_features_words_znorm(:,inmodel_layer1);
features_names_layer1 = {features_names_layer1{inmodel_layer1}};

for k=1:length(features_names_layer1)
       features_names_layer1{k} = strrep( features_names_layer1{k} , '_', ' ' ); 
       features_names_layer1{k} = strrep( features_names_layer1{k} , 'F.', '' ); 
       features_names_layer1{k} = strrep( features_names_layer1{k} , '.', ' ' ); 
end


%Perform a Clustering Kmeans K=8
nb_clust_layer1 = 8;
[ Entropy_Struct_layer1 , cluster_indexes_layer1 , cluster_centers_layer1 ] = ...
    kmean_clustering_and_entropy_measures( all_features_words_znorm , labels_words , nb_clust_layer1 , label_names , features_names_layer1 );


figure(),
plot_correlation_circle_pca( all_features_words_znorm , features_names_layer1 , 1 , 2 );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Layer 2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Writers_Features = [];
Writers_Ages = [];
for k=1:length(Writers)
   
    kWriter = Writers(k);
    bool_writer_words = strcmp( {All_Words.Writer_ID} , kWriter.Metadata.Writer_ID);
    if(sum(bool_writer_words)>3)
        
        writer_cluster_index_layer1 = cluster_indexes_layer1(bool_writer_words);
        writer_word_features_layer1 = cluster_indexes_layer1(bool_writer_words);
        
        
        
        writer_bow = compute_bag_of_words_distribution( writer_cluster_index_layer1 , max(cluster_indexes_layer1) );       
        Pairwise_Distance = compute_pairwise_word_distance_unidimensional_statistics( writer_word_features_layer1 );
        Writer_Word_Stats = compute_word_features_unidimensional_statistics( writer_word_features_layer1 );
        
        HFeatures.Bag_of_Words      = writer_bow;
        HFeatures.Pairwise_Distance = Pairwise_Distance.mean;
        HFeatures.Writer_Word_Stats = Writer_Word_Stats.mean;
                    

        
        [ l2Features , features_names_layer2 ] = get_features_from_struct( HFeatures , 'F' ); 
                    
        Writers_Features = [ Writers_Features; l2Features ];
        Writers_Ages = [ Writers_Ages; kWriter.Metadata.Writer_Age ];
    end
   
    
end

Writers_Features_znorm = zscore(Writers_Features);


[ inmodel_layer2 , hist ] = feature_selection_with_interclass_inertia_for_classification( Writers_Features_znorm , Writers_Labels , 10 );
%kept_layer2 = [57,9,2,17,3,58,79,1,23,10,6,77,89,75,69,71,4,84,40,86,90,93,62,60,85,26,48,21,68,27,95,94,37,43,73,59,70,13,50,8,7,46,29,32,14,63,87,80,31,53];
%kept_layer2 = [9,2,3,58,79,75,25,6,21,14,4,64,69,53,89,67,60,38,62,8]; %,67,60,38,62,70



Writers_Features_znorm = Writers_Features_znorm(:,inmodel_layer2);
features_names_layer2  = {features_names_layer2{[ inmodel_layer2 ]}};

for k=1:length(features_names_layer2)
    features_names_layer2{k} = strrep( features_names_layer2{k} , '_', ' ' ); 
    features_names_layer2{k} = strrep( features_names_layer2{k} , 'F.', '' ); 
    features_names_layer2{k} = strrep( features_names_layer2{k} , '.', ' ' ); 
end


nb_clust_layer2 = 3;
[ Entropy_Struct_layer2 , cluster_indexes_layer2 , cluster_centers_layer2 ] = ...
    kmean_clustering_and_entropy_measures( Writers_Features_znorm , Writers_Labels , nb_clust_layer2 , label_names , features_names_layer2 );




category_names_layer2 = {'Cluster 1','Cluster 2','Cluster 3'};
writer_names = {};
writer_age   = {};
for k=1:length(Writers)
    writer_names{k} = Writers(k).Metadata.Writer_ID;
    writer_age{k} = num2str(Writers(k).Metadata.Writer_Age);
end


figure(),
plot_correlation_circle_pca( Writers_Features_znorm , features_names_layer2 , 1 , 2 );

