function [ mutual_entropy_matrix ] = compute_mutual_information_matrix( data )

    [ ~ , ncols ] = size(data);
    
    mutual_entropy_matrix = zeros(ncols);
    
    for j=1:ncols
        for k = j:ncols
            mutual_entropy_matrix(j,k) = mutualinfo( data(:,j) , data(:,k) );
        end
    end
    
    mutual_entropy_matrix = mutual_entropy_matrix + mutual_entropy_matrix';
    mutual_entropy_matrix(1:ncols+1:end) = mutual_entropy_matrix(1:ncols+1:end)/2;

%     imagesc(mutual_entropy_matrix);
%     colormap(jet(64));
%     colorbar();
%     axis([ -ncols/10 (ncols +0.5 ) -ncols/5 (ncols +0.5 )])
%     for k=1:ncols
%         text( 0 , k , features_names{k},'HorizontalAlignment' ,'right','VerticalAlignment' ,'middle','FontWeight','bold','FontSize', 12)
%     end
%     for k=1:ncols
%         h = text( k, 0 , features_names{k},'HorizontalAlignment' ,'left','VerticalAlignment' ,'middle','FontWeight','bold','FontSize', 12);
%         set(h, 'rotation', 90);
%     end  

end