function [ energy ] = costfunc_for_feature_selection_interclass_inertias( features , labels  )

    [ inertia_intra , inertia_inter , ~ ] = compute_class_inertias_matrix( features , labels );
    energy = sum(inertia_intra) -1*sum(inertia_inter);
    
end