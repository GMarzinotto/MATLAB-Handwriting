output_file_folder  = 'E:\Try\';
feature_to_bin      = {'Speed','Acceleration','Jerk','Normalized_Jerk'};
tracking_type       = {'ON_TABLET','ON_AIR','ON_TABLET_ON_AIR'};
bin_numbers         = [4];


use_x = true;
use_y = true;
use_xabs = true;
use_yabs = true;
use_l2  = true;
use_l1  = true;
use_li  = true;
use_lin = true;



List_Of_All_Words = All_Words;
nWords = length(List_Of_All_Words);

for j=1:length(tracking_type)
    
    jtracking_type = tracking_type{j};
    
    for k=1:length(feature_to_bin)

        kfeature_to_bin = feature_to_bin{k};
        
        all_words_x = [];
        all_words_y = [];
        for l=1:nWords

           lWord    = List_Of_All_Words(l);
           lWord = convert_word_to_a_new_tracking_type( lWord , jtracking_type );
           if(~isempty(lWord) && lWord.NumSamples > 10 )
               switch(kfeature_to_bin)
                   case 'Speed'
                       [ ~ , x_val , y_val ] = compute_valid_speeds( lWord );
                   case 'Acceleration'
                       [ ~ , x_val , y_val ] = compute_valid_accelerations( lWord );
                   case 'Jerk'
                       [ ~ , x_val , y_val ] = compute_valid_jerks( lWord );
                   case 'Normalized_Jerk'
                       [ ~ , x_val , y_val ] = compute_valid_normalized_jerks( lWord );
               end

                   all_words_x = [ all_words_x; x_val ];
                   all_words_y = [ all_words_y; y_val ];
                   
           end
        end

        [norm_l2 , norm_l1 , norm_linf , norm_linfn, abs_x , abs_y ] = compute_all_norms(all_words_x , all_words_y);


        for kbins = bin_numbers

            array_printer       = ' %d ';
            for o=1:kbins-2
                array_printer = strcat( array_printer , ' %d ');
            end

            output_file         = strcat('Bin_Delimiters_',kfeature_to_bin,'_',jtracking_type,'_',num2str(kbins),'bins.m');
            fid = fopen(strcat(output_file_folder,output_file),'w');

            %X
            if(use_x)
                [ x_bin_unif ] = train_bin_separators_uniformely( all_words_x , kbins );
                [ x_bin_perc ] = train_bin_separators_using_percentils( all_words_x , kbins );
                [ x_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( all_words_x , kbins );
                fprintf(fid,' %% X \n ');
                fprintf(fid,strcat('Bins.%s.%s.X.Bins%d.Uniform             =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , x_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.X.Bins%d.Percentils          =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , x_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.X.Bins%d.Quantification      =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , x_bin_quan );
            end
            %Y
            if(use_y)
                [ y_bin_unif ] = train_bin_separators_uniformely( all_words_y , kbins );
                [ y_bin_perc ] = train_bin_separators_using_percentils( all_words_y , kbins );
                [ y_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( all_words_y , kbins );
                fprintf(fid,'%% Y \n ');
                fprintf(fid,strcat('Bins.%s.%s.Y.Bins%d.Uniform             =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , y_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.Y.Bins%d.Percentils          =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , y_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.Y.Bins%d.Quantification      =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , y_bin_quan );
            end
            %absX
            if(use_xabs)
                [ xabs_bin_unif ] = train_bin_separators_uniformely( abs_x , kbins );
                [ xabs_bin_perc ] = train_bin_separators_using_percentils( abs_x , kbins );
                [ xabs_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( abs_x , kbins );
                fprintf(fid,'%% Abs X \n ');
                fprintf(fid,strcat('Bins.%s.%s.absX.Bins%d.Uniform          =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , xabs_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.absX.Bins%d.Percentils       =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , xabs_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.absX.Bins%d.Quantification   =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , xabs_bin_quan );
            end
            %%absY
            if(use_yabs)
                [ yabs_bin_unif ] = train_bin_separators_uniformely( abs_y , kbins );
                [ yabs_bin_perc ] = train_bin_separators_using_percentils( abs_y , kbins );
                [ yabs_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( abs_y , kbins );
                fprintf(fid,'%% Abs Y \n ');
                fprintf(fid,strcat('Bins.%s.%s.absY.Bins%d.Uniform          =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , yabs_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.absY.Bins%d.Percentils       =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , yabs_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.absY.Bins%d.Quantification   =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , yabs_bin_quan );    
            end
            %L2
            if(use_l2)
                [ l2_bin_unif ] = train_bin_separators_uniformely( norm_l2 , kbins );
                [ l2_bin_perc ] = train_bin_separators_using_percentils( norm_l2 , kbins );
                [ l2_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( norm_l2 , kbins );
                fprintf(fid,'%% L2 \n ');
                fprintf(fid,strcat('Bins.%s.%s.L2.Bins%d.Uniform            =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , l2_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.L2.Bins%d.Percentils         =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , l2_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.L2.Bins%d.Quantification     =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , l2_bin_quan );
            end

            %L1
            if(use_l1)
                [ l1_bin_unif ] = train_bin_separators_uniformely( norm_l1 , kbins );
                [ l1_bin_perc ] = train_bin_separators_using_percentils( norm_l1 , kbins );
                [ l1_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( norm_l1 , kbins );
                fprintf(fid,'%% L1 \n ');
                fprintf(fid,strcat('Bins.%s.%s.L1.Bins%d.Uniform            =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , l1_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.L1.Bins%d.Percentils         =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , l1_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.L1.Bins%d.Quantification     =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , l1_bin_quan );
            end
            %Li
            if(use_li)
                [ li_bin_unif ] = train_bin_separators_uniformely( norm_linf , kbins );
                [ li_bin_perc ] = train_bin_separators_using_percentils( norm_linf , kbins );
                [ li_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( norm_linf , kbins );
                fprintf(fid,'%% Li \n ');
                fprintf(fid,strcat('Bins.%s.%s.Li.Bins%d.Uniform            =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , li_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.Li.Bins%d.Percentils         =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , li_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.Li.Bins%d.Quantification     =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , li_bin_quan );
            end
            %Lin
            if(use_lin)
                [ lin_bin_unif ] = train_bin_separators_uniformely( norm_linfn , kbins );
                [ lin_bin_perc ] = train_bin_separators_using_percentils( norm_linfn , kbins );
                [ lin_bin_quan ] = train_bin_separators_using_vectorial_quantification_kmeans( norm_linfn , kbins );
                fprintf(fid,'%% Lin \n ');
                fprintf(fid,strcat('Bins.%s.%s.Lin.Bins%d.Uniform           =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , lin_bin_unif );
                fprintf(fid,strcat('Bins.%s.%s.Lin.Bins%d.Percentils        =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , lin_bin_perc );
                fprintf(fid,strcat('Bins.%s.%s.Lin.Bins%d.Quantification    =  [', array_printer ,'];\n '), kfeature_to_bin , jtracking_type, kbins , lin_bin_quan );
            end

            fclose(fid);
        end
    end
end