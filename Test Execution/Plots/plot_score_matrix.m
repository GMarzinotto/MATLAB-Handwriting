function [] = plot_score_matrix(model_coefficients , labels_names_row , labels_names_col )

    [mrows,ncols] = size(model_coefficients);
    
    if(nargin == 1)
        for k=1:mrows
            labels_names_row{k} =  strcat('Group',num2str(k));
        end
        for k=1:ncols
            labels_names_col{k} =  strcat('Group',num2str(k));
        end
    end
    
    if( length(labels_names_row) == mrows && length(labels_names_col) == ncols )
        
        imagesc(model_coefficients);
        colormap(jet(64));
        colorbar();
        axis([0 (ncols +0.5 ) 0 (mrows +0.5 )])
        for k=1:mrows
            text(0.25 , k , labels_names_row{k},'HorizontalAlignment' ,'center','VerticalAlignment' ,'middle','FontWeight','bold','FontSize', 12)
        end
        for k=1:ncols
            text( k, 0.25 , labels_names_col{k},'HorizontalAlignment' ,'center','VerticalAlignment' ,'middle','FontWeight','bold','FontSize', 12)
        end  
         
    else
        error('Invalid plot')
    end


end