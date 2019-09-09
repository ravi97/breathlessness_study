function []=calc_features()

zoom_list=dir('zoom');
mkdir('features_new');

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
    
    label_0=[];
    label_1=[];
    
    sentence_0=[];
    sentence_1=[];
    
    for j=1:size(timings,1)
        sen=s(timings(j,1):timings(j,2));
        class_0=sen(1:floor(length(sen)/2));
        class_1=sen(floor(length(sen)/2)+1:end);
        len_0=length(class_0)/Fs;
        len_1=length(class_1)/Fs;
        
        for p=1:(floor(len_0*2)-1)
            mfcc_0=melcepst(class_0(1:Fs),Fs,'MdD',12);
            features_0=[features_0;[mean(mfcc_0),median(mfcc_0),mode(mfcc_0),std(mfcc_0),var(mfcc_0),rms(mfcc_0)]];
            class_0=class_0(Fs/2:end);
        end
        sentence_0=[sentence_0;ones(p,1)*j];
        label_0=[label_0;zeros(p,1)];
        
        for p=1:(floor(len_1*2)-1)
            mfcc_1=melcepst(class_1(1:Fs),Fs,'MdD',12);
            features_1=[features_1;[mean(mfcc_1),median(mfcc_1),mode(mfcc_1),std(mfcc_1),var(mfcc_1),rms(mfcc_1)]];
            class_1=class_1(Fs/2:end);
        end
        sentence_1=[sentence_1;ones(p,1)*j];
        label_1=[label_1;ones(p,1)];
    
    end
    features=[features_0;features_1];
    labels=[label_0;label_1];
    sentences=[sentence_0;sentence_1];
    save(['features_new/',zoom_list(i).name(1:len-4),'.mat'],'features','labels','sentences');
   

end


end