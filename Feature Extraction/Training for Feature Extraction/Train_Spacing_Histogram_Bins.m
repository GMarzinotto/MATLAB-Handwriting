

output_file_folder  = 'E:\Try\';
feature_to_bin      = {'Horizontal_ConvexHull_Spacing','Horizontal_Box_Spacing','Horizontal_MedianLine_Spacing','Horizontal_Penup_Spacing'}; 
bin_numbers         = [3:5];


List_Of_All_Words = All_Words;
nWords = length(List_Of_All_Words);

    
for k=1:length(feature_to_bin)

    kfeature_to_bin = feature_to_bin{k};
    
    all_vals = [];
    for l=1:nWords

       lWord    = List_Of_All_Words(l);
       
       switch(kfeature_to_bin)
           case 'Horizontal_Box_Spacing'
               unidim_val = compute_horizontal_box_spacing(lWord);
               is_unidimensional = true;
           case 'Horizontal_ConvexHull_Spacing'
               unidim_val = compute_horizontal_convexhull_spacing(lWord);
               is_unidimensional = true;
           case 'Horizontal_MedianLine_Spacing'
               unidim_val = compute_horizontal_medianline_spacing(lWord);
               is_unidimensional = true;
           case 'Horizontal_Penup_Spacing'
               unidim_val = compute_horizontal_penup_spacing(lWord);
               is_unidimensional = true;
       end

       if(is_unidimensional)
            all_vals = [all_vals; unidim_val ];
       end

    end

    

    for kbins = bin_numbers

        array_printer       = ' %d ';
        for o=1:kbins-2
            array_printer = strcat( array_printer , ' %d ');
        end

        output_file         = strcat('Bin_Delimiters_',kfeature_to_bin,'_',num2str(kbins),'bins.m');
        fid = fopen(strcat(output_file_folder,output_file),'w');

        if(is_unidimensional)
            [ unidim_bin_unif ] = train_bin_separators_uniformely( all_vals , kbins );
            [ unidim_bin_perc ] = train_bin_separators_using_percentils( all_vals , kbins );
            [ unidim_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( all_vals , kbins );
            fprintf(fid,' %% Unidimensional \n ');
            fprintf(fid,strcat('Bins.%s.Bins%d.Uniform             =  [', array_printer ,'];\n '), kfeature_to_bin ,  kbins , unidim_bin_unif );
            fprintf(fid,strcat('Bins.%s.Bins%d.Percentils          =  [', array_printer ,'];\n '), kfeature_to_bin ,  kbins , unidim_bin_perc );
            fprintf(fid,strcat('Bins.%s.Bins%d.Quantification      =  [', array_printer ,'];\n '), kfeature_to_bin ,  kbins , unidim_bin_quan );               
        end
        fclose(fid);
    end
end
