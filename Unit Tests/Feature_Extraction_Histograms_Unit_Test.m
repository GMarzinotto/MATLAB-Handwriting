
[ Word ] = read_file_wacom_app('E:\Databases Stage\Final Database\CH BE_19_02_1939\Test2.txt');

%% Speed
speed_on_air_4bins_uniform = compute_speed_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Uniform' , 'Basic' );
speed_on_air_4bins_percent = compute_speed_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Percentils' , 'Basic' );
speed_on_air_4bins_quantif = compute_speed_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Quantification' , 'Basic' );

speed_on_tablet_4bins_uniform = compute_speed_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
speed_on_tablet_4bins_percent = compute_speed_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
speed_on_tablet_4bins_quantif = compute_speed_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

speed_on_both_4bins_uniform = compute_speed_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
speed_on_both_4bins_percent = compute_speed_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
speed_on_both_4bins_quantif = compute_speed_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );

%% Acceleration
acceleration_on_air_4bins_uniform = compute_acceleration_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Uniform' , 'Basic' );
acceleration_on_air_4bins_percent = compute_acceleration_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Percentils' , 'Basic' );
acceleration_on_air_4bins_quantif = compute_acceleration_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Quantification' , 'Basic' );

acceleration_on_tablet_4bins_uniform = compute_acceleration_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
acceleration_on_tablet_4bins_percent = compute_acceleration_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
acceleration_on_tablet_4bins_quantif = compute_acceleration_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

acceleration_on_both_4bins_uniform = compute_acceleration_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
acceleration_on_both_4bins_percent = compute_acceleration_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
acceleration_on_both_4bins_quantif = compute_acceleration_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );



%% Jerk
jerk_on_air_4bins_uniform = compute_jerk_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Uniform' , 'Basic' );
jerk_on_air_4bins_percent = compute_jerk_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Percentils' , 'Basic' );
jerk_on_air_4bins_quantif = compute_jerk_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Quantification' , 'Basic' );

jerk_on_tablet_4bins_uniform = compute_jerk_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
jerk_on_tablet_4bins_percent = compute_jerk_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
jerk_on_tablet_4bins_quantif = compute_jerk_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

jerk_on_both_4bins_uniform = compute_jerk_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
jerk_on_both_4bins_percent = compute_jerk_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
jerk_on_both_4bins_quantif = compute_jerk_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );


%% penup_time
penup_time_on_air_4bins_uniform = compute_penup_time_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Uniform' , 'Basic' );
penup_time_on_air_4bins_percent = compute_penup_time_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Percentils' , 'Basic' );
penup_time_on_air_4bins_quantif = compute_penup_time_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Quantification' , 'Basic' );

penup_time_on_tablet_4bins_uniform = compute_penup_time_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
penup_time_on_tablet_4bins_percent = compute_penup_time_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
penup_time_on_tablet_4bins_quantif = compute_penup_time_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

penup_time_on_both_4bins_uniform = compute_penup_time_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
penup_time_on_both_4bins_percent = compute_penup_time_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
penup_time_on_both_4bins_quantif = compute_penup_time_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );



%% pressure
pressure_on_tablet_4bins_uniform = compute_pressure_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
pressure_on_tablet_4bins_percent = compute_pressure_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
pressure_on_tablet_4bins_quantif = compute_pressure_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

pressure_on_both_4bins_uniform = compute_pressure_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
pressure_on_both_4bins_percent = compute_pressure_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
pressure_on_both_4bins_quantif = compute_pressure_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );


%% pressure_derivative_wrt_xy
pressure_derivative_wrt_xy_on_tablet_4bins_uniform = compute_pressure_derivative_wrt_xy_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
pressure_derivative_wrt_xy_on_tablet_4bins_percent = compute_pressure_derivative_wrt_xy_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
pressure_derivative_wrt_xy_on_tablet_4bins_quantif = compute_pressure_derivative_wrt_xy_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

pressure_derivative_wrt_xy_on_both_4bins_uniform = compute_pressure_derivative_wrt_xy_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
pressure_derivative_wrt_xy_on_both_4bins_percent = compute_pressure_derivative_wrt_xy_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
pressure_derivative_wrt_xy_on_both_4bins_quantif = compute_pressure_derivative_wrt_xy_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );


%% pressure_derivative_wrt_time
pressure_derivative_wrt_time_on_tablet_4bins_uniform = compute_pressure_derivative_wrt_time_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
pressure_derivative_wrt_time_on_tablet_4bins_percent = compute_pressure_derivative_wrt_time_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
pressure_derivative_wrt_time_on_tablet_4bins_quantif = compute_pressure_derivative_wrt_time_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

pressure_derivative_wrt_time_on_both_4bins_uniform = compute_pressure_derivative_wrt_time_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
pressure_derivative_wrt_time_on_both_4bins_percent = compute_pressure_derivative_wrt_time_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
pressure_derivative_wrt_time_on_both_4bins_quantif = compute_pressure_derivative_wrt_time_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );

%% altitude angle
altitude_on_air_4bins_uniform = compute_altitude_angle_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Uniform' , 'Basic' );
altitude_on_air_4bins_percent = compute_altitude_angle_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Percentils' , 'Basic' );
altitude_on_air_4bins_quantif = compute_altitude_angle_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Quantification' , 'Basic' );

altitude_on_tablet_4bins_uniform = compute_altitude_angle_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
altitude_on_tablet_4bins_percent = compute_altitude_angle_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
altitude_on_tablet_4bins_quantif = compute_altitude_angle_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

altitude_on_both_4bins_uniform = compute_altitude_angle_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
altitude_on_both_4bins_percent = compute_altitude_angle_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
altitude_on_both_4bins_quantif = compute_altitude_angle_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );


%% azimuth angle
azimuth_on_air_4bins_uniform = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Uniform' , 'Basic' );
azimuth_on_air_4bins_percent = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Percentils' , 'Basic' );
azimuth_on_air_4bins_quantif = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_AIR' , 4 , 'Quantification' , 'Basic' );

azimuth_on_tablet_4bins_uniform = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Uniform' , 'Basic' );
azimuth_on_tablet_4bins_percent = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Percentils' , 'Basic' );
azimuth_on_tablet_4bins_quantif = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_TABLET' , 4 , 'Quantification' , 'Basic' );

azimuth_on_both_4bins_uniform = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Uniform' , 'Basic' );
azimuth_on_both_4bins_percent = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Percentils' , 'Basic' );
azimuth_on_both_4bins_quantif = compute_azimuth_angle_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 4 , 'Quantification' , 'Basic' );



%% inclination angle
inclination_on_air_8bins_uniform = compute_inclination_unidimentional_histograms( Word , 'ON_AIR' , 8 , 'Uniform' , 'Basic' );
inclination_on_air_8bins_percent = compute_inclination_unidimentional_histograms( Word , 'ON_AIR' , 8 , 'Percentils' , 'Basic' );
inclination_on_air_8bins_quantif = compute_inclination_unidimentional_histograms( Word , 'ON_AIR' , 8 , 'Quantification' , 'Basic' );

inclination_on_tablet_8bins_uniform = compute_inclination_unidimentional_histograms( Word , 'ON_TABLET' , 8 , 'Uniform' , 'Basic' );
inclination_on_tablet_8bins_percent = compute_inclination_unidimentional_histograms( Word , 'ON_TABLET' , 8 , 'Percentils' , 'Basic' );
inclination_on_tablet_8bins_quantif = compute_inclination_unidimentional_histograms( Word , 'ON_TABLET' , 8 , 'Quantification' , 'Basic' );

inclination_on_both_8bins_uniform = compute_inclination_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 8 , 'Uniform' , 'Basic' );
inclination_on_both_8bins_percent = compute_inclination_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 8 , 'Percentils' , 'Basic' );
inclination_on_both_8bins_quantif = compute_inclination_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 8 , 'Quantification' , 'Basic' );



%% curvature
curvature_w2_on_air_8bins_uniform = compute_curvature_unidimentional_histograms( Word , 'ON_AIR' , 2 , 8 , 'Uniform' , 'Basic' );
curvature_w2_on_air_8bins_percent = compute_curvature_unidimentional_histograms( Word , 'ON_AIR' , 2 , 8 , 'Percentils' , 'Basic' );
curvature_w2_on_air_8bins_quantif = compute_curvature_unidimentional_histograms( Word , 'ON_AIR' , 2 , 8 , 'Quantification' , 'Basic' );

curvature_w2_on_tablet_8bins_uniform = compute_curvature_unidimentional_histograms( Word , 'ON_TABLET' , 2 , 8 , 'Uniform' , 'Basic' );
curvature_w2_on_tablet_8bins_percent = compute_curvature_unidimentional_histograms( Word , 'ON_TABLET' , 2 , 8 , 'Percentils' , 'Basic' );
curvature_w2_on_tablet_8bins_quantif = compute_curvature_unidimentional_histograms( Word , 'ON_TABLET' , 2 , 8 , 'Quantification' , 'Basic' );

curvature_w2_on_both_8bins_uniform = compute_curvature_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 2 , 8 , 'Uniform' , 'Basic' );
curvature_w2_on_both_8bins_percent = compute_curvature_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 2 , 8 , 'Percentils' , 'Basic' );
curvature_w2_on_both_8bins_quantif = compute_curvature_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 2 , 8 , 'Quantification' , 'Basic' );


%% stroke length penup
stroke_length_penup_on_air_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'PENUP_CRITERION' , 4 , 'Uniform' , 'Basic' );
stroke_length_penup_on_air_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'PENUP_CRITERION' , 4 , 'Percentils' , 'Basic' );
stroke_length_penup_on_air_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'PENUP_CRITERION' , 4 , 'Quantification' , 'Basic' );

stroke_length_penup_on_tablet_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'PENUP_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_penup_on_tablet_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'PENUP_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_penup_on_tablet_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'PENUP_CRITERION'  , 4 , 'Quantification' , 'Basic' );

stroke_length_penup_on_both_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'PENUP_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_penup_on_both_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'PENUP_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_penup_on_both_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'PENUP_CRITERION'  , 4 , 'Quantification' , 'Basic' );



%% stroke length vx criterion
stroke_length_vx_on_air_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VX_CRITERION' , 4 , 'Uniform' , 'Basic' );
stroke_length_vx_on_air_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VX_CRITERION' , 4 , 'Percentils' , 'Basic' );
stroke_length_vx_on_air_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VX_CRITERION' , 4 , 'Quantification' , 'Basic' );
              
stroke_length_vx_on_tablet_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VX_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_vx_on_tablet_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VX_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_vx_on_tablet_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VX_CRITERION'  , 4 , 'Quantification' , 'Basic' );
              
stroke_length_vx_on_both_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VX_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_vx_on_both_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VX_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_vx_on_both_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VX_CRITERION'  , 4 , 'Quantification' , 'Basic' );


%% stroke length vy criterion
stroke_length_vy_on_air_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VY_CRITERION' , 4 , 'Uniform' , 'Basic' );
stroke_length_vy_on_air_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VY_CRITERION' , 4 , 'Percentils' , 'Basic' );
stroke_length_vy_on_air_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VY_CRITERION' , 4 , 'Quantification' , 'Basic' );
               
stroke_length_vy_on_tablet_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VY_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_vy_on_tablet_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VY_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_vy_on_tablet_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VY_CRITERION'  , 4 , 'Quantification' , 'Basic' );
               
stroke_length_vy_on_both_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VY_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_vy_on_both_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VY_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_vy_on_both_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VY_CRITERION'  , 4 , 'Quantification' , 'Basic' );



%% stroke length vxvy criterion
stroke_length_vxvy_on_air_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VX_VY_CRITERION' , 4 , 'Uniform' , 'Basic' );
stroke_length_vxvy_on_air_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VX_VY_CRITERION' , 4 , 'Percentils' , 'Basic' );
stroke_length_vxvy_on_air_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_AIR' , 'VX_VY_CRITERION' , 4 , 'Quantification' , 'Basic' );
               
stroke_length_vxvy_on_tablet_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VX_VY_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_vxvy_on_tablet_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VX_VY_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_vxvy_on_tablet_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET' , 'VX_VY_CRITERION'  , 4 , 'Quantification' , 'Basic' );
               
stroke_length_vxvy_on_both_4bins_uniform = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VX_VY_CRITERION'  , 4 , 'Uniform' , 'Basic' );
stroke_length_vxvy_on_both_4bins_percent = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VX_VY_CRITERION'  , 4 , 'Percentils' , 'Basic' );
stroke_length_vxvy_on_both_4bins_quantif = compute_stroke_length_unidimentional_histograms( Word , 'ON_TABLET_ON_AIR' , 'VX_VY_CRITERION'  , 4 , 'Quantification' , 'Basic' );




