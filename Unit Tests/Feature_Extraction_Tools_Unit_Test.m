%Read Files and Feature Extraction

mainPath = 'E:\Dropbox\MATLAB\HWToolbox\Demo\Demo Database\Wacom';
files = dir(mainPath);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
subFolders(1:2) = [];
All_Words = [];
Writers = [];
Labels = [];
all_features = [];
%Loop for each person
for i = 1 : 3
    %Loop for each Word
    personID = subFolders(i).name;
    filePath = strcat(mainPath,'\',personID);
    iWriter  = read_full_person_wacom_app(filePath);

    for j=1:2
        if (isfield(iWriter,strcat('Test',num2str(j))))
            
            jTest = eval(strcat('iWriter.Test',num2str(j)));
            jline_segments = segment_full_text_by_lines(jTest);
            nsegments = length(jline_segments);

            
            for k=1:nsegments
                
                kline_segment = recalibrate_word(jline_segments(k));  
                  
                %Dinamic Feature Extraction On Tablet
                Speed_Tablet        = compute_speed_unidimentional_statistics(kline_segment,'ON_TABLET');  
                Acceleration_Tablet = compute_acceleration_unidimentional_statistics(kline_segment,'ON_TABLET');
                Jerk_Tablet         = compute_jerk_unidimentional_statistics(kline_segment,'ON_TABLET');

                %Dinamic Feature Extraction Air
                Speed_Air           = compute_speed_unidimentional_statistics(kline_segment,'ON_AIR');
                Acceleration_Air    = compute_acceleration_unidimentional_statistics(kline_segment,'ON_AIR');
                Jerk_Air            = compute_jerk_unidimentional_statistics(kline_segment,'ON_AIR');
                
				%Penup Feature Extraction
                penup_ratio  	= compute_penup_time_ratio(kline_segment);
				penup_fequency 	= compute_penup_fequency(kline_segment);
				Penups  		= compute_penup_time_unidimentional_statistics(kline_segment);
				
				%Pressure Feature Extraction
                Pressure			= compute_pressure_unidimentional_statistics(kline_segment,'ON_TABLET');
				Pressure_Dev_Time  	= compute_pressure_derivative_wrt_time_unidimentional_statistics(kline_segment,'ON_TABLET');
				Pressure_Dev_XY  	= compute_pressure_derivative_wrt_xy_unidimentional_statistics(kline_segment,'ON_TABLET');

				%Penup Stroke Feature Extraction On Tablet
				Penup_Stroke_Length_Tablet 			= compute_stroke_length_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'PENUP_CRITERION' );
				Penup_Stroke_TimeDuration_Tablet 	= compute_stroke_time_duration_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'PENUP_CRITERION' );

				%Penup Stroke Feature Extraction On Air
				Penup_Stroke_Length_Air 		= compute_stroke_length_unidimentional_statistics( kline_segment , 'ON_AIR' , 'PENUP_CRITERION' );
				Penup_Stroke_TimeDuration_Air 	= compute_stroke_time_duration_unidimentional_statistics( kline_segment , 'ON_AIR' , 'PENUP_CRITERION' );
			
				%Vx Stroke Feature Extraction On Tablet
				Vx_Stroke_Length_Tablet 		= compute_stroke_length_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'VX_CRITERION' );
				Vx_Stroke_TimeDuration_Tablet 	= compute_stroke_time_duration_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'VX_CRITERION' );
				
				%Vy Stroke Feature Extraction On Tablet
				Vy_Stroke_Length_Tablet 		= compute_stroke_length_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'VY_CRITERION' );
				Vy_Stroke_TimeDuration_Tablet 	= compute_stroke_time_duration_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'VY_CRITERION' );
				
				%Vx_Vy Stroke Feature Extraction On Tablet
				Vx_Vy_Stroke_Length_Tablet 			= compute_stroke_length_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'VX_VY_CRITERION' );
				Vx_Vy_Stroke_TimeDuration_Tablet 	= compute_stroke_time_duration_unidimentional_statistics( kline_segment , 'ON_TABLET' , 'VX_VY_CRITERION' );

				

				%Resample Word 
				[resampled_kline_segment] = resample_word( kline_segment );
				
				%Spatial Feature Extraction On Tablet
                Inclinations_Tablet = compute_inclination_unidimentional_statistics(resampled_kline_segment,'ON_TABLET');
                Curvatures_Tablet   = compute_curvature_unidimentional_statistics(resampled_kline_segment,4,'ON_TABLET');
				
				%Spatial Feature Extraction On Air
                Inclinations_Air    = compute_inclination_unidimentional_statistics(resampled_kline_segment,'ON_AIR');
                Curvatures_Air      = compute_curvature_unidimentional_statistics(resampled_kline_segment,4,'ON_AIR');
				
				%Pen Angle Feature Extraction On Tablet
				Altitude_Angle_Tablet  	= compute_altitude_angle_unidimentional_statistics( resampled_kline_segment , 'ON_TABLET' );
				Azimuth_Angle_Tablet 	= compute_azimuth_angle_unidimentional_statistics( resampled_kline_segment  , 'ON_TABLET' );
				
				%Pen Angle Feature Extraction On Air
				Altitude_Angle_Air  = compute_altitude_angle_unidimentional_statistics( resampled_kline_segment , 'ON_AIR' );
				Azimuth_Angle_Air 	= compute_azimuth_angle_unidimentional_statistics( resampled_kline_segment  , 'ON_AIR' );
				
				
				%Compress all features in a single Struct_Features
				Struct_Features.Speed_Tablet = Speed_Tablet;
				Struct_Features.Acceleration_Tablet = Acceleration_Tablet;
				Struct_Features.Jerk_Tablet = Jerk_Tablet;
				Struct_Features.Speed_Air = Speed_Air;
				Struct_Features.Acceleration_Air = Acceleration_Air;
				Struct_Features.Jerk_Air = Jerk_Air;
				Struct_Features.penup_ratio = penup_ratio;
				Struct_Features.penup_fequency = penup_fequency;
				Struct_Features.Penups = Penups;
				Struct_Features.Pressure = Pressure;
				Struct_Features.Pressure_Dev_Time = Pressure_Dev_Time;
				Struct_Features.Pressure_Dev_XY = Pressure_Dev_XY;
				Struct_Features.Penup_Stroke_Length_Tablet = Penup_Stroke_Length_Tablet;
				Struct_Features.Penup_Stroke_TimeDuration_Tablet = Penup_Stroke_TimeDuration_Tablet;
				Struct_Features.Penup_Stroke_Length_Air = Penup_Stroke_Length_Air;
				Struct_Features.Penup_Stroke_TimeDuration_Air = Penup_Stroke_TimeDuration_Air;
				Struct_Features.Vx_Stroke_Length_Tablet = Vx_Stroke_Length_Tablet;
				Struct_Features.Vx_Stroke_TimeDuration_Tablet = Vx_Stroke_TimeDuration_Tablet;
				Struct_Features.Vy_Stroke_Length_Tablet = Vy_Stroke_Length_Tablet;
				Struct_Features.Vy_Stroke_TimeDuration_Tablet = Vy_Stroke_TimeDuration_Tablet;
				Struct_Features.Vx_Vy_Stroke_Length_Tablet = Vx_Vy_Stroke_Length_Tablet;
				Struct_Features.Vx_Vy_Stroke_TimeDuration_Tablet = Vx_Vy_Stroke_TimeDuration_Tablet;				
                Struct_Features.Inclinations_Tablet = Inclinations_Tablet;
				Struct_Features.Curvatures_Tablet = Curvatures_Tablet;
				Struct_Features.Inclinations_Air = Inclinations_Air;
				Struct_Features.Curvatures_Air = Curvatures_Air;
				Struct_Features.Altitude_Angle_Tablet = Altitude_Angle_Tablet;
				Struct_Features.Azimuth_Angle_Tablet = Azimuth_Angle_Tablet;
				Struct_Features.Altitude_Angle_Air = Altitude_Angle_Air;
				Struct_Features.Azimuth_Angle_Air = Azimuth_Angle_Air;
				
				[ features , names ] = get_features_from_struct( Struct_Features , 'F' ); 
                all_features = [all_features; features];  
                
                  
            end
        end
    end
    
    Writers = [Writers; iWriter];
        
end


%Centre and Z-Normalization
zFeatures = zscore(all_features);
