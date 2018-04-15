function [ features , names ] = get_features_from_struct( struct_feature , name ) 

    if(isstruct(struct_feature))
        names = {};
        features = [];
        fields_name_list = fieldnames(struct_feature);
        nfields = length(fields_name_list);
        for k=1:nfields
            [ kfeatures , knames ] = get_features_from_struct( getfield(struct_feature,fields_name_list{k} ) , strcat(name,'.',fields_name_list{k}) ); 
            for m=1:length(knames)
                names{end + 1} = knames{m};
            end
            features = [features kfeatures];
        end
    else
        features = struct_feature;
        names{1} = name;
    end

end