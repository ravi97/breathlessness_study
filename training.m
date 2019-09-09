function [] = training()

train_list=dir('inter/train');
mkdir('inter/models');

for i=10:11%size(train_list,1)
    train=load(['inter/train/',train_list(i).name]);
    len=length(train_list(i).name);
    savemat=['inter/models/',train_list(i).name(1:len-4),'_model.mat'];
    libsvmtrain(train.xtrain,train.ytrain,savemat);
    
end

end