function [ inertia_intra , inertia_inter , category_distances ] = compute_class_inertias_matrix( features , labels , plotgraph , labels_names )

    if(nargin<3)
        plotgraph = false;
    end

    Nclass   = length(unique(labels));
    uniq_lab = unique(labels);
    Nindivid = size(features,1);
    features = features - repmat(mean(features),Nindivid,1);
    total_inertia = pow2(norm(features))/Nindivid;
    inertia_intra = zeros(Nclass,1);
    inertia_inter = zeros(Nclass,1);
    category_distances = zeros(Nclass);
    
    meanFeatures = mean(features);
    for k=1:Nclass
        kfeatures = features(labels == uniq_lab(k),:);
        kNindivid = size(kfeatures,1);
        kfeatures = kfeatures - repmat(mean(kfeatures),kNindivid,1);
        inertia_intra(k) = pow2(norm(kfeatures))/total_inertia;
        inertia_inter(k) = (kNindivid/Nindivid)*pow2(norm(mean(kfeatures) - meanFeatures ))/total_inertia;
    end
    
    
    for k=1:Nclass-1
        for j=k+1:Nclass
            kfeatures = mean(features(labels == uniq_lab(k),:));
            jfeatures = mean(features(labels == uniq_lab(j),:));
            category_distances(k,j) = pow2(norm((kfeatures)-(jfeatures)))/total_inertia;
            category_distances(j,k) = category_distances(k,j);
        end
    end

    
    if(plotgraph)
        if(nargin < 4)
            plot_score_matrix( category_distances);
        else
            plot_score_matrix( category_distances , labels_names , labels_names );
        end
    end
    
end