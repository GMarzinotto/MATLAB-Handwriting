output_file_folder  = 'E:\Try\';
feature_to_bin      = {'Azimuth','Altitude'}; 
tracking_type       = {'ON_TABLET','ON_AIR','ON_TABLET_ON_AIR'};
bin_numbers         = [3:5];




List_Of_All_Words = All_Words;
nWords = length(List_Of_All_Words);

for j=1:length(tracking_type)
    
    jtracking_type = tracking_type{j};
    
    for k=1:length(feature_to_bin)

        kfeature_to_bin = feature_to_bin{k};
        
        all_vals = [];
        for l=1:nWords

           lWord = List_Of_All_Words(l);
           lWord = convert_word_to_a_new_tracking_type( lWord , jtracking_type );

           switch(kfeature_to_bin)
               case 'Azimuth'
                   unidim_val = lWord.Az;
                   is_unidimensional = true;
               case 'Altitude'
                   unidim_val = lWord.Al;
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

            output_file         = strcat('Bin_Delimiters_',kfeature_to_bin,'_',jtracking_type,'_',num2str(kbins),'bins.m');
            fid = fopen(strcat(output_file_folder,output_file),'w');

            if(is_unidimensional)
                [ unidim_bin_unif ] = train_bin_separators_uniformely( all_vals , kbins );
                [ unidim_bin_perc ] = train_bin_separators_using_percentils( all_vals , kbins );
                [ unidim_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( all_vals , kbins );
                fprintf(fid,' %% Unidimensional \n ');
                fprintf(fid,strcat('Bins.%s.%s.Bins%d.Uniform             =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , unidim_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.Bins%d.Percentils          =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , unidim_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.Bins%d.Quantification      =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , unidim_bin_quan );               
            end
            fclose(fid);
        end
    end
end