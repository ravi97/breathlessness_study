function [] = testing()
test_list=dir('inter/test');
mkdir('inter/results');

for i=3:size(test_list,1)
    test=load(['inter/test/',test_list(i).name]);
    len=length(test_list(i).name);
    savemat=['inter/models/',test_list(i).name(1:len-4),'_model.mat'];
    [pred,acc,decv]=libsvmtest(savemat,test.xtest,test.ytest);
    save(['inter/results/',test_list(i).name],'pred','acc','decv');
    
end


end