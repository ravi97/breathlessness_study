function []=calc_features3()

zoom_list=dir('zoom');
mkdir('features3');

for i=3:size(zoom_list,1)
    
    [s,Fs]=audioread(['zoom/',zoom_list(i).name]);
    s=s(:,1);

    len=length(zoom_list(i).name);
    ts_file=[zoom_list(i).name(1:len-10),'exact_start_stop_',zoom_list(i).name(len-8:len-4),'.txt'];
    f_id=fopen(['modified_timestamps/',ts_file]);
    timings=textscan(f_id,'%f %f %s\n');
    timings=cell2mat(timings(1:2));
    timings=round(timings*Fs);
    fclose(f_id);
    
    features_0=[];
    features_1=[];
    features_2=[];
    
    for j=1:size(timings,1)
        sen=s(timings(j,1):timings(j,2));
        class_0=sen(1:floor(length(sen)/3));
        class_1=sen(floor(length(sen)/3)+1:2*floor(length(sen)/3));
        class_2=sen(2*floor(length(sen)/3)+1:end);
        mfcc_0=melcepst(class_0,Fs,'MdD',12);
        mfcc_1=melcepst(class_1,Fs,'MdD',12);
        mfcc_2=melcepst(class_2,Fs,'MdD',12);
        features_0=[features_0;[mean(mfcc_0),median(mfcc_0),mode(mfcc_0),std(mfcc_0),var(mfcc_0),rms(mfcc_0)]];
        features_1=[features_1;[mean(mfcc_1),median(mfcc_1),mode(mfcc_1),std(mfcc_1),var(mfcc_1),rms(mfcc_1)]];
        features_2=[features_2;[mean(mfcc_2),median(mfcc_2),mode(mfcc_2),std(mfcc_2),var(mfcc_2),rms(mfcc_2)]];
    
    end
    features=[features_0;features_1;features_2];
    save(['features3/',zoom_list(i).name(1:len-4),'.mat'],'features');
   

end


end