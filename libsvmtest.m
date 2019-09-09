function [pred,ac,decv] = libsvmtest(savemat,test_data,test_label)

load(savemat);
addpath(genpath('libsvm-3.22/'));

test_data=(test_data-repmat(MEAN,size(test_data,1),1))./...
    repmat(STD,size(test_data,1),1);

[pred,ac,decv] = svmpredict(test_label, test_data, model,' -b 1 ');