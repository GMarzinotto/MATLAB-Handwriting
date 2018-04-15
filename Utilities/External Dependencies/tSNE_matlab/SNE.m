%%%TESTING SNE%%%%%
no_dims_Words=2;
init_dims_Words=24;
perplexity_Words=10;

[m,n] = size(CENTRE);

parameterExtractionMatrix_Words = DynamicParametersOnWords;
SNEMatrix = [parameterExtractionMatrix_Words([1:10:end],:); CENTRE];
mappedX_Words=tsne(SNEMatrix, [], no_dims_Words, init_dims_Words, perplexity_Words);


for k=1:m
    CentroSNE_Words(k,:) = mappedX_Words(end,:);
    mappedX_Words(end,:)=[];
end

mappedX_Words=[mappedX_Words IDX(1:10:end)];



colors = distinguishable_colors(max(mappedX_Words(:,3))+1);

for i=1:length(mappedX_Words)
    
    plot(mappedX_Words(i,1), mappedX_Words(i,2), '+', 'Color', colors(mappedX_Words(i,3)+1,:));     
    hold on
    
end

for k=1:n
    plot(CentroSNE_Words(k,1), CentroSNE_Words(k,2), '*', 'Color',colors(1,:),'markersize',20)
end