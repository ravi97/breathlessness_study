function [] = libsvmtrain(train1,train_label,savemat)

addpath(genpath('libsvm-3.22/'));

bestcv = 0;
bestc=0;
bestg=0;

MEAN=mean(train1);
STD=std(train1);
train_data=(train1-repmat(MEAN,size(train1,1),1))./repmat(STD,size(train1,1),1);

for log2c = -3:10,
    for log2g = -2:10,
        cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(train_label,train_data, cmd);
        [2^log2c,2^log2g]
        if (cv >= bestcv),
            bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
        end
        fprintf('(best c=%g, g=%g, rate=%g)\n',bestc, bestg, bestcv);
    end
end

model = svmtrain(train_label,train_data, [' -b 1 -c ' num2str(bestc) '-g ' num2str(bestg)]);
save(savemat,'model','MEAN','STD','bestc','bestg','bestcv');