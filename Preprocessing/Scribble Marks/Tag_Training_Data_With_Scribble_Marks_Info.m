labeled_writers = {'AP_GE_24_01_1924' , 'AR_AN_07_07_1934' , 'AR_BE_09_05_1924' , 'AU_MA_18_09_1938' , 'BA_CH_18_03_1949' , ...
                   'BA_GI_13_03_1940' , 'BA_MA_28_05_1941' , 'BA_MA_29_03_1951' , 'BA_SE_09_10_1941' , 'BA_VI_15_05_1930' };


%% AP_GE_24_01_1924
Punctuation_Database.AP_GE_24_01_1924.Test1.Scribble         = [  ];
Punctuation_Database.AP_GE_24_01_1924.Test2.Scribble         = [  ];


%% AR_AN_07_07_1934
Punctuation_Database.AR_AN_07_07_1934.Test1.Scribble         = [  ];
Punctuation_Database.AR_AN_07_07_1934.Test2.Scribble         = [ 1 ];


%% AR_BE_09_05_1924
Punctuation_Database.AR_BE_09_05_1924.Test1.Scribble         = [  ];
Punctuation_Database.AR_BE_09_05_1924.Test2.Scribble         = [  ];


%% AU_MA_18_09_1938
Punctuation_Database.AU_MA_18_09_1938.Test1.Scribble         = [  ];
Punctuation_Database.AU_MA_18_09_1938.Test2.Scribble         = [  ];


%% BA_CH_18_03_1949
Punctuation_Database.BA_CH_18_03_1949.Test1.Scribble         = [  ];
Punctuation_Database.BA_CH_18_03_1949.Test2.Scribble         = [  ];



%% BA_GI_13_03_1940
Punctuation_Database.BA_GI_13_03_1940.Test1.Scribble         = [  ];
Punctuation_Database.BA_GI_13_03_1940.Test2.Scribble         = [ 21 22 35 ];


%% BA_MA_28_05_1941
Punctuation_Database.BA_MA_28_05_1941.Test1.Scribble         = [ 54 55 93 106 108 ];
Punctuation_Database.BA_MA_28_05_1941.Test2.Scribble         = [ 15 17 128 139 ];


%% BA_MA_29_03_1951
Punctuation_Database.BA_MA_29_03_1951.Test1.Scribble         = [ 128 ];
Punctuation_Database.BA_MA_29_03_1951.Test2.Scribble         = [  ];


%% BA_SE_09_10_1941
Punctuation_Database.BA_SE_09_10_1941.Test1.Scribble         = [  ];
Punctuation_Database.BA_SE_09_10_1941.Test2.Scribble         = [ 100 ];


%% BA_VI_15_05_1930
Punctuation_Database.BA_VI_15_05_1930.Test1.Scribble         = [  ];
Punctuation_Database.BA_VI_15_05_1930.Test2.Scribble         = [  ];



%%
% Diacritic_Database..Test1.Scribble         = [  ];
% Diacritic_Database..Test2.Scribble         = [  ];


labeled_writers_indexes = [];

for i=1:length(labeled_writers)

    
    writer_idx = find( ismember( {Writers.Writer_ID} , labeled_writers{i} ) );
    
    if(~isnan(writer_idx))
        
        labeled_writers_indexes = [labeled_writers_indexes; writer_idx];
        kWriter                 = Writers(writer_idx);
        
        for j=1:2
            if(isfield(kWriter,strcat('Test',num2str(j))))
                jTest = eval(strcat('kWriter.Test',num2str(j),';'));
                if(isfield(jTest,'is_scribble_marks') && strcmp(jTest.Tracking,'ON_TABLET') )            
                    scribble_stroke_idx   = eval(strcat('Punctuation_Database.',labeled_writers{i},'.Test',num2str(j),'.Scribble;'));
                    
                    
                    for k=1:length(scribble_stroke_idx)
                        jTest.is_scribble_marks(scribble_stroke_idx(k)) = true;
                    end
                    
                    
                    eval(strcat('Writers(i).Test',num2str(j),' = jTest;'));
                end
            end
        end
    end
end