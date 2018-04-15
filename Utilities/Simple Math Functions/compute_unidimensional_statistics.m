function [avg_val , std_val , min_val, max_val , ran_val , per_obj , ske_val , kur_val ] = compute_unidimensional_statistics(values_vec)
%% compute_unidimentional_statistics
%  Computes all the classic unidimentional statistics indicators
%  mean, std, min, max, range and percentils in steps of 5%
%  0% 5% 10%... 45% 50% 55% ... 90% 95% 100%
%  This function may be used to compute unidimentional statistcs on 
%  position, speed, acceleration, jerk, pressure, etc...
%
% [ _avg_val_ , _std_val_ , _min_val_ , _max_val_ , _ran_val_ , _per_val_ , _ske_val_ , _kur_val_ ] = _*compute_unidimentional_statistics*_ ( _comp_x_ , _comp_y_ )
%
%%% Inputs
% 
% * *values_vec*      : Avector of components to perform unidimentional 
%                       statistics on, could be position, speed, etc...
%
%%% Outputs
% 
% * *avg_val* : Average value of the input vector
%
% * *std_val* : Standard Deviation value of the input vector
%
% * *min_val* : Minimum value of the input vector
%
% * *max_val* : Maximum value of the input vector
%
% * *ran_val* : Range of values of the input vector
%
% * *per_val* : Percentils 25% 50% 75% of the input vector
%
% * *ske_val* : Skewness value of the input vector
%
% * *kur_val* : Kurtosis value of the input vector
%

%% Authors and Modification Log
% 
%  Author :     G. Marzinotto (May 2016)
%  Modified by: ---
%%

    avg_val = mean(values_vec);
    std_val = std(values_vec);
    min_val = min(values_vec);
    max_val = max(values_vec);
    ran_val = max_val - min_val;        
        
    ske_val = skewness(values_vec);
    kur_val = kurtosis(values_vec);
    
    per_val = prctile(values_vec,[5:5:95]); 

    if( isempty(values_vec) )
        min_val = NaN;
        max_val = NaN;
        ran_val = NaN;
    end
    
    [a,b] = size(values_vec);
    if( a>1 && b>1 )

        per_obj.q5   = per_val(1,:);
        per_obj.q10  = per_val(2,:);
        per_obj.q15  = per_val(3,:);
        per_obj.q20  = per_val(4,:);
        per_obj.q25  = per_val(5,:);
        per_obj.q30  = per_val(6,:);
        per_obj.q35  = per_val(7,:);
        per_obj.q40  = per_val(8,:);
        per_obj.q45  = per_val(9,:);
        per_obj.q50  = per_val(10,:);
        per_obj.q55  = per_val(11,:);
        per_obj.q60  = per_val(12,:);
        per_obj.q65  = per_val(13,:);
        per_obj.q70  = per_val(14,:);
        per_obj.q75  = per_val(15,:);
        per_obj.q80  = per_val(16,:);
        per_obj.q85  = per_val(17,:);
        per_obj.q90  = per_val(18,:);
        per_obj.q95  = per_val(19,:);
    
    else

        per_obj.q5   = per_val(1);
        per_obj.q10  = per_val(2);
        per_obj.q15  = per_val(3);
        per_obj.q20  = per_val(4);
        per_obj.q25  = per_val(5);
        per_obj.q30  = per_val(6);
        per_obj.q35  = per_val(7);
        per_obj.q40  = per_val(8);
        per_obj.q45  = per_val(9);
        per_obj.q50  = per_val(10);
        per_obj.q55  = per_val(11);
        per_obj.q60  = per_val(12);
        per_obj.q65  = per_val(13);
        per_obj.q70  = per_val(14);
        per_obj.q75  = per_val(15);
        per_obj.q80  = per_val(16);
        per_obj.q85  = per_val(17);
        per_obj.q90  = per_val(18);
        per_obj.q95  = per_val(19);

    end
end