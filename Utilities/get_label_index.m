function [ Label ] = get_label_index( class_label_name , label_list )


    if(length(unique(label_list)) ~= length(label_list))
        error('label_list has repeated labels');
    end
   
    Label = NaN;
    
    for k=1:length(label_list)
        if( strcmp( class_label_name , label_list{k} ) )
            Label = k;
        end
    end


end