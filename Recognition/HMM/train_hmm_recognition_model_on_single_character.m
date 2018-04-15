function [ HMM_Model ] = train_hmm_recognition_model_on_single_character( character_feature_list , numOfGaussians , numOfStates , cov_type , transition_mat_arch , prior_prob )


    if(nargin < 2)
        numOfGaussians = 2;
    end
    if(nargin < 3)
        numOfStates = 3;
    end
    if(nargin < 4)
        cov_type = 'full';
    end
    if(nargin < 5)
       %%% transmission probabilities
       transition_mat_arch =  mk_leftright_transmat( numOfStates , 0.5 );
    end
    if(nargin < 6)
        prior_prob = [ 1; zeros( numOfStates-1 , 1 ) ];
        %prior0 = normalise(rand(numOfStates,1)); %%% prior probabilities
    end
    

    %HMM Parameters
    %TODO: Modify the architecture of the HMM Network
    %This means changing the number of states, gaussians
    %and also testing different architectures modifying the prior0
    %and transmat0 matrices.
    %transmat0 = mk_stochastic sets to be a fully connected HMM!
    %See doc of HMM All for more detailled information on architectures
    
    [ ~ , numParameters ] = size(character_feature_list{1})   ;
    
       
    %GM Model Initialization
    [mu0, Sigma0] = mixgauss_init(numOfStates*numOfGaussians, character_feature_list{1}, cov_type);
    mu0 = reshape(mu0, [numParameters numOfStates numOfGaussians]);
    Sigma0 = reshape(Sigma0, [numParameters numParameters numOfStates numOfGaussians]);
    mixmat0 = mk_stochastic(rand(numOfStates,numOfGaussians));
        
    %Training HMM
    [LL, prior1, transmat1, mu1, sigma1,mixmat1] = mhmm_em(character_feature_list, ...
                                                           prior_prob, transition_mat_arch, mu0, Sigma0, mixmat0,...
                                                           'max_iter', 10,'cov_type',cov_type);
    %Storing a Model in the final structure
    HMM_Model = struct('prior',prior1,'transmat',transmat1,'mu',mu1,'sigma',sigma1,'mixmat',mixmat1);




end