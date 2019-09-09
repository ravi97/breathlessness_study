 function training(STIMULITYPE,training_set,no_of_feature)

% clear all;
% close all;
% STIMULITYPE='cough';
% training_set=[1 2 4];test_set=[3];
DIR='/home/pghosh/Documents/shivani_documents/Asthma/Practicum2/';
allfiles=dir([DIR '/data_inhale_exhale/training_testing_8-24/*.txt'])
 C_feature =[];
 P_feature =[];
 train1=[];
 train_label=[];
 no_of_statistics=6; 
%dim=no_of_statistics*no_of_feature*2;   
 dim=no_of_statistics*no_of_feature ;
%dim=no_of_statistics;
%%%%%%%%%%%%%%%%%%%%Reading each set file%%%%%%%%%%%%%%%%%%%%
for i=1:3
    
file=allfiles(training_set(i)).name ;
file=file(1:end-4) ;
Textfile=[DIR '/data_inhale_exhale/training_testing_8-24/' file '.txt'];
fileID =  fopen(Textfile) ;
data   =  textscan(fileID,'%s');
fclose(fileID);
   
             %%%%%%%%%%%Reading data of each file written in  training set txt file%%%%%%%%%%%%%%%%%%%%
for j=1:length(data{1,1})
chr2= data{1,1}{j,1} 
    Check=regexp(chr2,'Asthma'); %check for control and patient
    load([DIR '/data_inhale_exhale/statistics_8-24/' chr2 '.mat']);%
    switch STIMULITYPE
        case 'cough'
            feature=cough_feature;
        case 'wheeze'
            feature=wheeze_feature;
        case 'aa'
            feature=aa_feature;
        case 'uu'
            feature=uu_feature;
        case 'oo'
            feature=oo_feature;
        case 'yee'
            feature=yee_feature;
        case 'ee'
            feature=ee_feature;
                
         case 'ss'
            feature=ss_feature;
         case 'zz'
            feature=zz_feature;
          case 'inhale'
            %feature=[inhale_feature exhale_feature];
            % lengthin=length(inhale_feature);
 feature=inhale_feature;
%feature=exhale_feature;
         case 'exhale'
%             feature=[infeature exhale_feature];
            feature= exhale_feature;
         % feature= inhale_feature;
  
        otherwise
            error('Wrong STIMULITYPE');
        
    end
    %for k=1:length(lengthin)
     for k=1:length(feature)
% no_of_feature= 13;  
                 % temp=[feature{k}(:,1:no_of_feature) feature{k+lengthin}(:,1:no_of_feature)];
      % temp=feature{k}(:,w);
       temp=feature{k}(:,1:no_of_feature);
            column_vector = reshape(temp',dim,1);
            if isempty(Check)
                C_feature= [C_feature column_vector];
            else
                P_feature= [P_feature column_vector ];
            end
       
    end
end
end
                 %%%%%%%%%%%%%%%%%%%CREATING train1 or test_data%%%%%%%%%%%%%%%
 train1=[ P_feature';C_feature'];


   %%%%%%%%%% CREATING train_label or test_label column vector FOR TRAINING OR TEST DATA %%%%%%%%%%%%%
b=size(C_feature);
C_STIMULITYPE_number=b(2);
d=size(P_feature);
P_STIMULITYPE_number=d(2);
A=[];
train_label=[zeros(P_STIMULITYPE_number,1);ones(C_STIMULITYPE_number,1)] ; % assigning 0 for patient and 1 for control
z=mat2str(training_set);

%save([DIR 'training_testing/training_testing' num2str(no_of_feature) '/' 'combine_exhale' STIMULITYPE '_training_' z '.mat'],'A');
%save([DIR 'training_testingwithoutenergy/training_testing' num2str(no_of_feature) 'combine_exhale' STIMULITYPE '_training_' z '.mat'],'A');
% savemat=([DIR 'training_testingwithoutenergy/with_each_col36/' STIMULITYPE '_training_' z '.mat']);
% save([DIR 'training_testing/with_each_col' num2str(no_of_feature) '/' STIMULITYPE 'col' num2str(w) '_training_' z '.mat'],'A');
%savemat=([DIR 'training_testingpredict1/training_testing'  num2str(no_of_feature) '/'  STIMULITYPE  '_training_' z '.mat']);
%savemat=([DIR 'training_testingwithoutenergy/with_each_col'  num2str(no_of_feature) '/'  STIMULITYPE 'col' num2str(w) '_training_' z '.mat']);

savemat=([DIR '/data_inhale_exhale/training_testing_8-24/training_testing'  num2str(no_of_feature) '/'  STIMULITYPE  '_training_' z '.mat']);
%save([DIR 'training_testing/training_testing' num2str(no_of_feature) '/' '_exhale' STIMULITYPE '_training_' z '.mat'],'A');

libsvmtrain(train1,train_label,savemat) ;




