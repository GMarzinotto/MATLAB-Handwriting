function [Ev1,Ev2,Ev3] = eval_clusters_with_three_methods(Data,Algoritm,Range)

    if(nargin < 3)
        Range = 1:20;
    end
    if(nargin < 2) 
        Algoritm = 'kmeans';
    end

    Ev1 = evalclusters(Data,Algoritm,'silhouette','KList', Range);
    Ev2 = evalclusters(Data,Algoritm,'CalinskiHarabasz','klist', Range);
    Ev3 = evalclusters(Data,Algoritm,'DaviesBouldin','klist', Range);
    
    figure(),
    subplot(3,1,1), plot(Ev1)
	subplot(3,1,2), plot(Ev2)
    subplot(3,1,3), plot(Ev3)
    
end