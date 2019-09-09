%%%%%set stimulitype and number of feature to calculate training and testset %%%%
% close all;
% clear all;

DIR='/home/pghosh/Documents/shivani_documents/Asthma/Practicum2/';
%training_set=[1 2 3;1 3 4;2 3 4;1 2 4];test_set=[4;2;1;3]
training_set=[1 2 3 4];
% stimuli={'cough','wheeze','aa','uu','ee','yee','oo','ss','zz'};
%stimuli={'cough','wheeze','aa','uu','ee','yee','oo','inhale','exhale'};
stimuli={'wheeze'}%,'inhale','exhale'};

no_of_feature=[12 24 36];  % number of feature dimension
for k=1:length(no_of_feature)
    for j=1:length(stimuli)
        STIMULITYPE=stimuli{j}
        
        for i=1%:length(test_set)  %4 is no of fold
            pred=[];
            test_label=[];
            % dimension_set(STIMULITYPE,test_set(i,1),training_set(i,1:3))
            % dimension_set(STIMULITYPE,test_set,training_set)
            trainingnew(STIMULITYPE,training_set(i,1:4),no_of_feature(1,k));
            %         [pred,test_label]=testing(STIMULITYPE,test_set(i,1),training_set(i,1:3),no_of_feature);
            %         a=mat2str(training_set(i,1:3));
            %         b=mat2str(test_set(i));
            %       % save([DIR 'resultpredict/result' num2str(no_of_feature) '/' 'cross' STIMULITYPE a '_' b 'result.mat'], 'pred', 'test_label' );
            %         save([DIR '/data_inhale_exhale/results_8-24/results' num2str(no_of_feature) '/' STIMULITYPE a '_' b 'result.mat'], 'pred', 'test_label' );
            %
        end
    end
end
