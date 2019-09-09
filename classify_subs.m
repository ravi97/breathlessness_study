function []=classify_subs()

feature_list=dir('features_new');

n_set=3; % set this as 17 and run again
n_sub=0; %number of subjects


mkdir(['data_',num2str(n_set),'_sets_2_classes/12']);
mkdir(['data_',num2str(n_set),'_sets_2_classes/24']);
mkdir(['data_',num2str(n_set),'_sets_2_classes/36']);

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

struct2table(s);

features_12=cell(n_set,3);
features_24=cell(n_set,3);
features_36=cell(n_set,3);

for i=1:length(s)
    x_12=cell2mat(features_12(s(i).set,1));
    x_24=cell2mat(features_24(s(i).set,1));
    x_36=cell2mat(features_36(s(i).set,1));
    y=cell2mat(features_12(s(i).set,2));
    sen=cell2mat(features_12(s(i).set,3));
    
    mats=load(['features_new/',feature_list(i+2).name]);
    feat=mats.features;
    
%     x_12=[x_12;feat(:,1:13),feat(:,40:52),feat(:,79:91),feat(:,118:130),feat(:,157:169),feat(:,196:208)];
%     x_24=[x_24;feat(:,1:26),feat(:,40:65),feat(:,79:104),feat(:,118:143),feat(:,157:182),feat(:,196:221)];
%     x_36=[x_36;feat];
%     y=[y;mats.labels];
    %sen=[sen;mats.sentences];
    
    x_12=[x_12;feat(:,1:12),feat(:,37:48),feat(:,73:84),feat(:,109:120),feat(:,145:156),feat(:,181:192)];
    x_24=[x_24;feat(:,1:24),feat(:,37:60),feat(:,73:96),feat(:,109:132),feat(:,145:168),feat(:,181:204)];
    x_36=[x_36;feat];
    y=[y;mats.labels];
    
    
    features_12(s(i).set,1)={x_12};
    features_12(s(i).set,2)={y};
    features_12(s(i).set,3)={sen};
    
    features_24(s(i).set,1)={x_24};
    features_24(s(i).set,2)={y};
    features_24(s(i).set,3)={sen};
    
    features_36(s(i).set,1)={x_36};
    features_36(s(i).set,2)={y};
    features_36(s(i).set,3)={sen};
    
end

features=features_12;
save(['data_',num2str(n_set),'_sets_2_classes/12/data.mat'],'features');

features=features_24;
save(['data_',num2str(n_set),'_sets_2_classes/24/data.mat'],'features');

features=features_36;
save(['data_',num2str(n_set),'_sets_2_classes/36/data.mat'],'features');


end