function [Features] = feature_extraction_for_recognition( Word )

    %TODO: Veryfy if all features are usefull or eventually add more

    %Canonical Lines Distances
    [ median_line_dist , base_line_dist , upper_line_dist , minimum_line_dist , maximum_line_dist ] = distance_to_canonical_lines( Word , 0 , true );
    
    %Is Penup or Pendown
    [ is_penup_start ] = compute_penup_start(Word);
    [ is_penup_end ] = compute_penup_end(Word);
    
    %Curvature with size 10
    window_size = 10;
    [  angle_deg_w_10 , ~ , Trigonometry_Curvature_w_10 ] = compute_all_curvatures( Word , window_size ); 
    angle_deg_w_10 = [ angle_deg_w_10(1)*ones(window_size,1);     angle_deg_w_10;     angle_deg_w_10(end)*ones(window_size,1) ];
    
    %Sin Cos Tanh Sech
    auxvar = Trigonometry_Curvature_w_10.sin_angle_0_180;
    angle_deg_sin_w_10  = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    auxvar = Trigonometry_Curvature_w_10.cos_angle_0_180;
    angle_deg_cos_w_10  = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    auxvar = Trigonometry_Curvature_w_10.tanh_angle_0_180;
    angle_deg_tanh_w_10 = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    auxvar = Trigonometry_Curvature_w_10.sech_angle_0_180;
    angle_deg_sech_w_10 = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    
    %Curvature with size 20
    window_size = 20;
    [  angle_deg_w_20 , ~ , Trigonometry_Curvature_w_20 ] = compute_all_curvatures( Word , window_size );
    angle_deg_w_20 = [ angle_deg_w_20(1)*ones(window_size,1);     angle_deg_w_20;     angle_deg_w_20(end)*ones(window_size,1) ];
    
    %Sin Cos Tanh Sech
    auxvar = Trigonometry_Curvature_w_20.sin_angle_0_180;
    angle_deg_sin_w_20  = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    auxvar = Trigonometry_Curvature_w_20.cos_angle_0_180;
    angle_deg_cos_w_20  = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    auxvar = Trigonometry_Curvature_w_20.tanh_angle_0_180;
    angle_deg_tanh_w_20 = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    auxvar = Trigonometry_Curvature_w_20.sech_angle_0_180;
    angle_deg_sech_w_20 = [ auxvar(1)*ones(window_size,1); auxvar;  auxvar(end)*ones(window_size,1) ];
    
    
    %Inclination
    [ angle_deg_0_360 , angle_deg_0_180 , angle_deg_0_90 , Trigonometry_Inclination ] = compute_all_inclinations(Word);
        
    angle_deg_0_360 = [ angle_deg_0_360(1); angle_deg_0_360];
    angle_deg_0_180 = [ angle_deg_0_180(1); angle_deg_0_180];
    angle_deg_0_90  = [ angle_deg_0_90(1);  angle_deg_0_90 ];
    
    angle_deg_sin_inc_0_360  = [ Trigonometry_Inclination.sin_angle_0_360(1) ; Trigonometry_Inclination.sin_angle_0_360  ];
    angle_deg_cos_inc_0_360  = [ Trigonometry_Inclination.cos_angle_0_360(1) ; Trigonometry_Inclination.cos_angle_0_360  ];
    angle_deg_tanh_inc_0_360 = [ Trigonometry_Inclination.tanh_angle_0_360(1); Trigonometry_Inclination.tanh_angle_0_360 ];
    angle_deg_sech_inc_0_360 = [ Trigonometry_Inclination.sech_angle_0_360(1); Trigonometry_Inclination.tanh_angle_0_360 ];
    
    angle_deg_sin_inc_0_180  = [ Trigonometry_Inclination.sin_angle_0_180(1) ; Trigonometry_Inclination.sin_angle_0_180  ];
    angle_deg_cos_inc_0_180  = [ Trigonometry_Inclination.cos_angle_0_180(1) ; Trigonometry_Inclination.cos_angle_0_180  ];
    angle_deg_tanh_inc_0_180 = [ Trigonometry_Inclination.tanh_angle_0_180(1); Trigonometry_Inclination.tanh_angle_0_180 ];
    angle_deg_sech_inc_0_180 = [ Trigonometry_Inclination.sech_angle_0_180(1); Trigonometry_Inclination.tanh_angle_0_180 ];
    
    angle_deg_sin_inc_0_90  = [ Trigonometry_Inclination.sin_angle_0_90(1) ; Trigonometry_Inclination.sin_angle_0_90  ];
    angle_deg_cos_inc_0_90  = [ Trigonometry_Inclination.cos_angle_0_90(1) ; Trigonometry_Inclination.cos_angle_0_90  ];
    angle_deg_tanh_inc_0_90 = [ Trigonometry_Inclination.tanh_angle_0_90(1); Trigonometry_Inclination.tanh_angle_0_90 ];
    angle_deg_sech_inc_0_90 = [ Trigonometry_Inclination.sech_angle_0_90(1); Trigonometry_Inclination.tanh_angle_0_90 ];
    
    is_penup_start = double(is_penup_start);
    is_penup_end   = double(is_penup_end);
    
    [ bin_vals_for_sequence , bin_vals_normalized ] = sequential_neighborhood_bitmap_histogram( Word , 3 , 3 );
    
    %Construction of the Final Feature Vector
    Features = [ is_penup_start, is_penup_end, base_line_dist, maximum_line_dist, median_line_dist, minimum_line_dist, upper_line_dist, angle_deg_0_180, angle_deg_0_360, angle_deg_0_90, angle_deg_cos_inc_0_180, angle_deg_cos_inc_0_360, angle_deg_cos_inc_0_90, angle_deg_cos_w_10, angle_deg_cos_w_20, angle_deg_sech_inc_0_180, angle_deg_sech_inc_0_360, angle_deg_sech_inc_0_90, angle_deg_sech_w_10, angle_deg_sech_w_20, angle_deg_sin_inc_0_180, angle_deg_sin_inc_0_360, angle_deg_sin_inc_0_90, angle_deg_sin_w_10, angle_deg_sin_w_20, angle_deg_tanh_inc_0_180, angle_deg_tanh_inc_0_360, angle_deg_tanh_inc_0_90, angle_deg_tanh_w_10, angle_deg_tanh_w_20, angle_deg_w_10, angle_deg_w_20 , bin_vals_for_sequence , bin_vals_normalized ];
    

end