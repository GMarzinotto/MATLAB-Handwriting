function [ shear_angle ] = compute_horizontal_slant_angle( Word )

    Resolution = 100; % 300dpi
    PixelWidth = 2.54/Resolution; %pixel width in cm
    
    %Resample using the default distance
    Word = resample_word( Word ); 
    
    Entropy_List = [];
	Angle_List = [];
    for angle = -45:5:45
        newWord = shear_online_word_horizontally( Word , angle );
        sorted_array = sort(histcounts( newWord.X(newWord.P ~= 0) , floor((max(newWord.X) - min(newWord.X))/PixelWidth)  ));
        
        criterion_val = mean( sorted_array(end-8:end) );
        Entropy_List = [Entropy_List; criterion_val];
    	Angle_List   = [Angle_List; angle];
    end
    
    idx = find(Entropy_List == max(Entropy_List));
    angle_min = Angle_List(max(idx-1,1));
    angle_max = Angle_List(min(idx+1,length(Angle_List)));
    
    
    Entropy_List = [];
    Angle_List   = [];
    for angle = [angle_min:1:angle_max]
        newWord = shear_online_word_horizontally( Word , angle );
        sorted_array = sort(histcounts( newWord.X(newWord.P ~= 0) , floor((max(newWord.X) - min(newWord.X))/PixelWidth)  ));
        
        criterion_val = mean(sorted_array(end-8:end));
        
        Entropy_List = [Entropy_List; criterion_val ];
    	Angle_List   = [Angle_List; angle];
    end
    
    idx = find(Entropy_List == max(Entropy_List));
    shear_angle = Angle_List(idx(1));
    
    newWord = shear_online_word_horizontally( Word , shear_angle );
    
%     figure(),
%     subplot(2,1,1), plot_in_black_and_white(Word);
%     subplot(2,1,2), plot_in_black_and_white(newWord);
%     
    
end