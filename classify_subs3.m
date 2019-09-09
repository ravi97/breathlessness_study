function []=classify_subs3()

feature_list=dir('features3');


n_set=3;
n_sub=0; %number of subjects

mkdir(['data_',num2str(n_set),'_sets_3_classes/12']);
mkdir(['data_',num2str(n_set),'_sets_3_classes/24']);
mkdir(['data_',num2str(n_set),'_sets_3_classes/36']);

for i=3:size(feature_list,1)
    len=length(feature_list(i).name);
    s(i-2).name=strtok(feature_list(i).name,'_');
    s(i-2).part=str2num(feature_list(i).name(len-4));
    if s(i-2).part==1
        n_sub=n_sub+1;
    end
    
end

pos=find([s.part] == 1);
for i=1:length(pos)
    s(pos(i)).set=mod(i,n_set)+1;
end

for i= 1:length(s)-1
    if(strcmp(s(i).name,s(i+1).name)==1)
        if(s(i).part==2)
            s(i).set=s(i+1).set;
        else
            s(i+1).set=s(i).set;
        end
    end
end

features_12=cell(3,2);
features_24=cell(3,2);
features_36=cell(3,2);

for i=1:length(s)
    x_12=cell2mat(features_12(s(i).set,1));
    x_24=cell2mat(features_24(s(i).set,1));
    x_36=cell2mat(features_36(s(i).set,1));
    y=cell2mat(features_12(s(i).set,2));
    
    feat=load(['features3/',feature_list(i+2).name]);
    feat=feat.features;
    
    label=[zeros(size(feat,1)/3,1) ; ones(size(feat,1)/3,1) ; 2*ones(size(feat,1)/3,1)];
    x_12=[x_12;feat(:,1:12),feat(:,37:48),feat(:,73:84),feat(:,109:120),feat(:,145:156),feat(:,181:192)];
    x_24=[x_24;feat(:,1:24),feat(:,37:60),feat(:,73:96),feat(:,109:132),feat(:,145:168),feat(:,181:204)];
    x_36=[x_36;feat];
    y=[y;label];
    
    features_12(s(i).set,1)={x_12};
    features_12(s(i).set,2)={y};
    features_24(s(i).set,1)={x_24};
    features_24(s(i).set,2)={y};
    features_36(s(i).set,1)={x_36};
    features_36(s(i).set,2)={y};
    
end

set1=cell2mat(features_12(1,1));
set1_label=cell2mat(features_12(1,2));
set2=cell2mat(features_12(2,1));
set2_label=cell2mat(features_12(2,2));
set3=cell2mat(features_12(3,1));
set3_label=cell2mat(features_12(3,2));

save(['data_',num2str(n_set),'_sets_3_classes/12/data.mat'],'set1','set1_label','set2','set2_label','set3','set3_label');

set1=cell2mat(features_24(1,1));
set1_label=cell2mat(features_24(1,2));
set2=cell2mat(features_24(2,1));
set2_label=cell2mat(features_24(2,2));
set3=cell2mat(features_24(3,1));
set3_label=cell2mat(features_24(3,2));

save(['data_',num2str(n_set),'_sets_3_classes/24/data.mat'],'set1','set1_label','set2','set2_label','set3','set3_label');

set1=cell2mat(features_36(1,1));
set1_label=cell2mat(features_36(1,2));
set2=cell2mat(features_36(2,1));
set2_label=cell2mat(features_36(2,2));
set3=cell2mat(features_36(3,1));
set3_label=cell2mat(features_36(3,2));


save(['data_',num2str(n_set),'_sets_3_classes/36/data.mat'],'set1','set1_label','set2','set2_label','set3','set3_label');

end