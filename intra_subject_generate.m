function []=intra_subject_generate()

n_sets=17;
mkdir('intra/train');
mkdir('intra/test');

n_feat=[12,24,36];


for i=1:length(n_feat)
        
    data=load(['data_',num2str(n_sets),'_sets_2_classes/',num2str(n_feat(i)),'/data.mat']);
    for j=1:n_sets
        set_x=cell2mat(data.features(j,1));
        set_label=cell2mat(data.features(j,2));
        sen=cell2mat(data.features(j,3));
        
        m=length(set_label);
        
        xtrain=set_x(1:round(m*0.75),:);
        ytrain=set_label(1:round(m*0.75));
        xtest=set_x(round(m*0.75):end,:);
        ytest=set_label(round(m*0.75):end);
        %test_sentences=sen(round(m*0.75):end);
        save(['intra/train/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_123_4'],'xtrain','ytrain');
        save(['intra/test/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_123_4'],'xtest','ytest');
        
        xtrain=[set_x(1:round(m*0.5),:);set_x(round(m*0.75):end,:)];
        ytrain=[set_label(1:round(m*0.5));set_label(round(m*0.75):end)];
        xtest=set_x(round(m*0.5):round(m*0.75),:);
        ytest=set_label(round(m*0.5):round(m*0.75));
        %test_sentences=sen(round(m*0.5):round(m*0.75));
        save(['intra/train/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_124_3'],'xtrain','ytrain');
        save(['intra/test/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_124_3'],'xtest','ytest');
        
        xtrain=[set_x(1:round(m*0.25),:);set_x(round(m*0.5):end,:)];
        ytrain=[set_label(1:round(m*0.25));set_label(round(m*0.5):end)];
        xtest=set_x(round(m*0.25):round(m*0.5),:);
        ytest=set_label(round(m*0.25):round(m*0.5));
        %test_sentences=sen(round(m*0.25):round(m*0.5));
        save(['intra/train/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_134_2'],'xtrain','ytrain');
        save(['intra/test/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_134_2'],'xtest','ytest');
        
        xtrain=set_x(round(m*0.25):end,:);
        ytrain=set_label(round(m*0.25):end);
        xtest=set_x(1:round(m*0.25),:);
        ytest=set_label(1:round(m*0.25));
        %test_sentences=sen(1:round(m*0.25));
        save(['intra/train/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_234_1'],'xtrain','ytrain');
        save(['intra/test/',num2str(n_feat(i)),'_feat_',num2str(j),'_sub_234_1'],'xtest','ytest');
        
    end
        
end

end