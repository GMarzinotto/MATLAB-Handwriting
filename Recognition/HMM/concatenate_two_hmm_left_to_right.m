function [ combined_hmm ] = concatenate_two_hmm_left_to_right( left_hmm , right_hmm )


    [n_feat_left ,n_states_left ,n_gauss_left ] = size(left_hmm.mu);
    [n_feat_right,n_states_right,n_gauss_right] = size(right_hmm.mu);

    if( n_gauss_left ~= n_gauss_right || n_feat_left ~= n_feat_right )
       error('both HMM must have the same number of gaussians per state, as well as the same number of features!!! ') 
    end


    %new number of states is the sum of both hmms states
    new_number_of_states = n_states_left + n_states_right;

    %new prior probabilities. starts on the left...
    newPrior = [ left_hmm.prior ; zeros(size(right_hmm.prior)) ];
    
    %new transition matrix, the upper left block is the left_hmm
    %while the lower right block is the right_hmm. Then we fix the
    %transition between the 2 hmms using an average value per diagonal
    newTrans = zeros(new_number_of_states); %pre-allocate the matrix
    
    %fill the upper left corner
    newTrans( 1:n_states_left , 1:n_states_left ) = left_hmm.transmat;
    
    %fill the lower right corner
    newTrans( (end - n_states_right + 1):end , (end - n_states_right + 1):end ) = right_hmm.transmat;
    
    %fill the upper and lower diagonals of the matrix
    num_elem_TM = numel(newTrans);
    for k=1:new_number_of_states-1
        idx_up_diag = (k*new_number_of_states + 1):(new_number_of_states+1):num_elem_TM;
        idx_lo_diag = (k + 1):(new_number_of_states+1):num_elem_TM;
        newTrans( idx_up_diag( newTrans( idx_up_diag ) == 0 ) ) = mean(newTrans( idx_up_diag ));   
        newTrans( idx_lo_diag( newTrans( idx_lo_diag ) == 0 ) ) = mean(newTrans( idx_lo_diag ));  
    end
    
    %make sure row probabilities sum 1 and reescale to one otherwise
    for k=1:new_number_of_states
        newTrans(k,:) = newTrans(k,:)/sum(newTrans(k,:));
    end
    
    %combine the mu values
    newMu = [ left_hmm.mu right_hmm.mu ];
    
    %combine the sigma values
    newSigma = cat( 3 , left_hmm.sigma , right_hmm.sigma );
    
    %combine mixture matrixes
    newMixmat = [ left_hmm.mixmat; right_hmm.mixmat ];
    
    %create the final struct
    combined_hmm = struct('prior',newPrior,'transmat',newTrans,'mu',newMu,'sigma',newSigma,'mixmat',newMixmat);

end