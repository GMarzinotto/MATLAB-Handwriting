labeled_writers = {'AP_GE_24_01_1924' , 'AR_AN_07_07_1934' , 'AR_BE_09_05_1924' , 'AU_MA_18_09_1938' , 'BA_CH_18_03_1949' , ...
                   'BA_GI_13_03_1940' , 'BA_MA_28_05_1941' , 'BA_MA_29_03_1951' , 'BA_SE_09_10_1941' , 'BA_VI_15_05_1930' };

%%AP_GE_24_01_1924
Delayed_Database.AP_GE_24_01_1924.Test1.Delayed = [ 16 17 21 37 38 42 49 101 118 122 125 ];
Delayed_Database.AP_GE_24_01_1924.Test2.Delayed = [  3  7 21 70 80 95 96 112 115 120 125 128 134 ];

%%AR_AN_07_07_1934
Delayed_Database.AR_AN_07_07_1934.Test1.Delayed = [ 29 45 57 62 69 131 ];
Delayed_Database.AR_AN_07_07_1934.Test2.Delayed = [ 27 52 ];

%%AR_BE_09_05_1924
Delayed_Database.AR_BE_09_05_1924.Test1.Delayed = [ 32 37 38 51 52 53 58 65  70  76 108 142 143 ];
Delayed_Database.AR_BE_09_05_1924.Test2.Delayed = [  6 19 23 27 36 47 64 88 105 161 208];

%%AU_MA_18_09_1938
Delayed_Database.AU_MA_18_09_1938.Test1.Delayed = [ 23 41 42 47 58 ];
Delayed_Database.AU_MA_18_09_1938.Test2.Delayed = [ 32 ];

%%BA_CH_18_03_1949
Delayed_Database.BA_CH_18_03_1949.Test1.Delayed = [ 28 54 97 104 128 166 ];
Delayed_Database.BA_CH_18_03_1949.Test2.Delayed = [  6 19 ];

%%BA_GI_13_03_1940
Delayed_Database.BA_GI_13_03_1940.Test1.Delayed = [ 82 175 180 ];
Delayed_Database.BA_GI_13_03_1940.Test2.Delayed = [ 27  32  47 55 64 68 99 ];

%%BA_MA_28_05_1941
Delayed_Database.BA_MA_28_05_1941.Test1.Delayed = [ 23 27 40 42 43 44 48 53 78 104 106 107 108 131 132 ];
Delayed_Database.BA_MA_28_05_1941.Test2.Delayed = [  4 12 13 19 39 45 62 74 77  78 100 111 117 149 152 153 ];

%%BA_MA_29_03_1951
Delayed_Database.BA_MA_29_03_1951.Test1.Delayed = [ 28 44 45 50 56 63 110 136 140 ];
Delayed_Database.BA_MA_29_03_1951.Test2.Delayed = [  3 15 16 ];

%%BA_SE_09_10_1941
Delayed_Database.BA_SE_09_10_1941.Test1.Delayed = [ 18 23 40 41 100 ];
Delayed_Database.BA_SE_09_10_1941.Test2.Delayed = [  7 84 ];

%%BA_VI_15_05_1930
Delayed_Database.BA_VI_15_05_1930.Test1.Delayed = [ 24 54 61 133 135 ];
Delayed_Database.BA_VI_15_05_1930.Test2.Delayed = [  5 22 26  41  43 48 69 108 112 ];


%%a
%Delayed_Database..Test1.Delayed = [  ];
%Delayed_Database..Test2.Delayed = [  ];

labeled_writers_indexes = [];

for i=1:length(labeled_writers)

    
    writer_idx = find( ismember( {Writers.Writer_ID} , labeled_writers{i} ) );
    
    if(~isnan(writer_idx))
        
        labeled_writers_indexes = [labeled_writers_indexes; writer_idx];
        kWriter                 = Writers(writer_idx);
        
        for j=1:2
            if(isfield(kWriter,strcat('Test',num2str(j))))
                jTest = eval(strcat('kWriter.Test',num2str(j),';'));
                if(isfield(jTest,'is_delayed_stroke') && strcmp(jTest.Tracking,'ON_TABLET') )            
                    delayed_stroke_idx = eval(strcat('Delayed_Database.',labeled_writers{i},'.Test',num2str(j),'.Delayed;'));
                    jTest.is_delayed_stroke(delayed_stroke_idx) = true;
                    eval(strcat('Writers(i).Test',num2str(j),' = jTest;'));
                end
            end
        end
    end
end