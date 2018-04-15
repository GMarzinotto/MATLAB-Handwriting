clearvars;

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
idx = 1;
Labels = [];
%Loop for each person
for k = 1 : length(subFolders)
    %Loop for each Word
    personID = subFolders(k).name;
    filePath = strcat(mainPath,'\',personID);
    iWriter  = read_full_person_wacom_app(filePath);

    for j=1:2
        if (isfield(iWriter,strcat('Test',num2str(j))))
            
            full_text = eval(strcat('iWriter.Test',num2str(j)));
            line_segments = segment_full_text_by_lines(full_text);
            for i=1:length(line_segments)
                iWord = line_segments(i);
                
                %Feature Extraction On Tablet
                Speed_T           = compute_speed_unidimensional_statistics(iWord,'ON_TABLET');
                Acceleration_T    = compute_acceleration_unidimensional_statistics(iWord,'ON_TABLET');
                Jerk_T            = compute_jerk_unidimensional_statistics(iWord,'ON_TABLET');
                Inclinations_T    = compute_inclination_unidimensional_statistics(iWord,'ON_TABLET');
                Curvatures_T      = compute_curvature_unidimensional_statistics(iWord,'ON_TABLET',10);
                penup_ratio_T     = compute_penup_time_ratio(iWord);
                Pressure_T        = compute_pressure_unidimensional_statistics(iWord,'ON_TABLET');
                Altitude_Ang_T    = compute_altitude_angle_unidimensional_statistics( iWord , 'ON_TABLET' );

                %Feature Extraction Air
                Speed_A           = compute_speed_unidimensional_statistics(iWord,'ON_AIR');
                Acceleration_A    = compute_acceleration_unidimensional_statistics(iWord,'ON_AIR');
                Jerk_A            = compute_jerk_unidimensional_statistics(iWord,'ON_AIR');
                Inclinations_A    = compute_inclination_unidimensional_statistics(iWord,'ON_AIR');
                Curvatures_A      = compute_curvature_unidimensional_statistics(iWord,'ON_AIR',10);

                %Feature Extraction Both
                Speed_B           = compute_speed_unidimensional_statistics(iWord,'ON_TABLET_ON_AIR');
                Acceleration_B    = compute_acceleration_unidimensional_statistics(iWord,'ON_TABLET_ON_AIR');
                Jerk_B            = compute_jerk_unidimensional_statistics(iWord,'ON_TABLET_ON_AIR');
                Inclinations_B    = compute_inclination_unidimensional_statistics(iWord,'ON_TABLET_ON_AIR');
                Curvatures_B      = compute_curvature_unidimensional_statistics(iWord,'ON_TABLET_ON_AIR',10);


                All_Words = [All_Words; iWord];
                Features(idx,:) = [Speed_T.L2.mean               Acceleration_T.L2.mean      Jerk_T.L2.mean   ...
                                   Inclinations_T.angle_0_180.mean   Curvatures_T.angle_0_180.mean   ...
                                   Altitude_Ang_T.mean ...
                                   penup_ratio_T    Pressure_T.mean...
                                   Speed_A.L2.mean               Acceleration_A.L2.mean      Jerk_A.L2.mean   ...
                                   Inclinations_A.angle_0_180.mean   Curvatures_A.angle_0_180.mean ...
                                   Speed_B.L2.mean               Acceleration_B.L2.mean      Jerk_B.L2.mean   ...
                                   Inclinations_B.angle_0_180.mean   Curvatures_B.angle_0_180.mean ];
                if( strcmp(iWriter.Metadata.Writer_Gender, 'Male') )
                    Labels = [Labels; 1];
                else
                    Labels = [Labels; 2];
                end
                idx = idx+1;
            end
        end
    end
    
    Writers = [Writers; iWriter];
        
end

features_names = {'Speed Tablet L2 Mean','Accel Tablet L2 Mean','Jerk Tablet L2 Mean',...
                  'Inclination Tablet 0-180 Mean','Curvature Tablet 0-180 Mean','Penup Ratio','Pressure Mean',...
                  'Altitude Angle Tablet Mean', ...
                  'Speed Air L2 Mean','Accel Air L2 Mean','Jerk Air L2 Mean',...
                  'Inclination Air 0-180 Mean','Curvature Air 0-180 Mean',...
                  'Speed Both L2 Mean','Accel Both L2 Mean','Jerk Both L2 Mean',...
                  'Inclination Both 0-180 Mean','Curvature Both 0-180 Mean' };

labels_names = { 'Man' , 'Woman' };


%Centre and Z-Normalization
if any(isnan(Features(:)))
    xmu=nanmean(Features);
    xsigma=nanstd(Features);
    zFeatures=(Features-repmat(xmu,length(Features),1))./repmat(xsigma,length(Features),1);
else
    zFeatures=zscore(Features);
end
zFeatures(isnan(zFeatures)) = 0.0;



nb_clust = 3;                           
kmean_clustering_and_entropy_measures( zFeatures , Labels , nb_clust , labels_names , features_names )    
