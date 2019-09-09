function []=inter_subject_generate()

n_sets=3;
mkdir('inter/train');
mkdir('inter/test');

n_feat=[12,24,36];

for i=1:size(n_feat,2)
    feat=load(['data_',num2str(n_sets),'_sets_2_classes/',num2str(n_feat(i)),'/data.mat']);
    
    set1=cell2mat(feat.features(1,1));
    set1_label=cell2mat(feat.features(1,2));
    set1_sen=cell2mat(feat.features(1,3));

    set2=cell2mat(feat.features(2,1));
    set2_label=cell2mat(feat.features(2,2));
    set2_sen=cell2mat(feat.features(2,3));

    set3=cell2mat(feat.features(3,1));
    set3_label=cell2mat(feat.features(3,2));
    set3_sen=cell2mat(feat.features(3,3));
    
    xtrain=[set1;set2];
    ytrain=[set1_label;set2_label];
    xtest=set3;
    ytest=set3_label;
    test_sentences=set3_sen;
    save(['inter/train/',num2str(n_feat(i)),'_feat_12_3.mat'],'xtrain','ytrain');
    save(['inter/test/',num2str(n_feat(i)),'_feat_12_3.mat'],'xtest','ytest');
    
    
    xtrain=[set2;set3];
    ytrain=[set2_label;set3_label];
    xtest=set1;
    ytest=set1_label;
    test_sentences=set1_sen;
    save(['inter/train/',num2str(n_feat(i)),'_feat_23_1.mat'],'xtrain','ytrain');
    save(['inter/test/',num2str(n_feat(i)),'_feat_23_1.mat'],'xtest','ytest');
    
    xtrain=[set3;set1];
    ytrain=[set3_label;set1_label];
    xtest=set2;
    ytest=set2_label;
    test_sentences=set2_sen;
    save(['inter/train/',num2str(n_feat(i)),'_feat_31_2.mat'],'xtrain','ytrain');
    save(['inter/test/',num2str(n_feat(i)),'_feat_31_2.mat'],'xtest','ytest');
    
end

end