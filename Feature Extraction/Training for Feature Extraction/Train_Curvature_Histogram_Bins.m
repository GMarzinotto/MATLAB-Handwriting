

output_file_folder  = 'E:\Try\';
feature_to_bin      = {'Curvature'}; 
tracking_type       = {'ON_TABLET','ON_AIR','ON_TABLET_ON_AIR'}; 
Wsizes              = 10; 
bin_numbers         = [8];




List_Of_All_Words = All_Words;
nWords = length(List_Of_All_Words);


for j=1:length(tracking_type)
    
    jtracking_type = tracking_type{j};
    List_Of_All_Resampled_Words = [];
    
    %Resample all the Words Once
    for l=1:nWords 
        
        lWord = convert_word_to_a_new_tracking_type( List_Of_All_Words(l) , jtracking_type );
        if(~isempty(lWord))
            lWord = resample_word( lWord );
            List_Of_All_Resampled_Words = [List_Of_All_Resampled_Words; lWord]; 
        end
        
    end


    for i=Wsizes

        iwindow_size = strcat('Window_Size_',num2str(i));

        for k=1:length(feature_to_bin)

            kfeature_name = feature_to_bin{k};
            feature_name  = strcat(feature_to_bin{k},'_',iwindow_size);

            all_words_x = [];
            all_words_y = [];
            all_vals = [];
            for l=1:length( List_Of_All_Resampled_Words )
               
               lWord = List_Of_All_Resampled_Words(l);

               switch(kfeature_name)
                   case 'Curvature'
                       unidim_val = compute_valid_curvatures( lWord , i );
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

                output_file         = strcat('Bin_Delimiters_',feature_name,'_',jtracking_type,'_',num2str(kbins),'bins.m');
                fid = fopen(strcat(output_file_folder,output_file),'w');

                if(is_unidimensional)
                    [ unidim_bin_unif ] = train_bin_separators_uniformely( all_vals , kbins );
                    [ unidim_bin_perc ] = train_bin_separators_using_percentils( all_vals , kbins );
                    [ unidim_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( all_vals , kbins );
                    fprintf(fid,' %% Unidimensional \n ');
                    fprintf(fid,strcat('Bins.%s.%s.angle_0_180.Bins%d.Uniform             =  [', array_printer ,'];\n '), feature_name , jtracking_type, kbins , unidim_bin_unif );
                    fprintf(fid,strcat('Bins.%s.%s.angle_0_180.Bins%d.Percentils          =  [', array_printer ,'];\n '), feature_name , jtracking_type, kbins , unidim_bin_perc );
                    fprintf(fid,strcat('Bins.%s.%s.angle_0_180.Bins%d.Quantification      =  [', array_printer ,'];\n '), feature_name , jtracking_type, kbins , unidim_bin_quan );                   
                end
                fclose(fid);
            end
        end
    end
end