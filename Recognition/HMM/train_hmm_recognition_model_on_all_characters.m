function [ HMM_mapObj ] = train_hmm_recognition_model_on_all_characters( characters_mapObj )

    HMM_Models = {};
    for k=characters_mapObj.keys
       HMM_Models{k} = train_hmm_recognition_model_on_single_character( characters_mapObj(k) );
    end

    HMM_mapObj = containers.Map( characters_mapObj.keys , HMM_Models );
    
    save('HMM_Model_Characters','HMM_mapObj');

end