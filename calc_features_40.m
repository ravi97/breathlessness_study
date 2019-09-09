function []=calc_features_40()

zoom_list=dir('zoom');
mkdir('features');

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
    
    for j=1:size(timings,1)
        
        sen=s(timings(j,1):timings(j,2));
        
        try
            mfcc_0=melcepst(sen(1:floor(length(sen)*0.4)),Fs,'MEdD',12);
            mfcc_1=melcepst(sen(floor(length(sen)*0.6):end),Fs,'MEdD',12);
        catch
            zoom_list(i).name,j
        end
        features_0=[features_0;[mean(mfcc_0),median(mfcc_0),mode(mfcc_0),std(mfcc_0),var(mfcc_0),rms(mfcc_0)]];
        features_1=[features_1;[mean(mfcc_1),median(mfcc_1),mode(mfcc_1),std(mfcc_1),var(mfcc_1),rms(mfcc_1)]];
        
    end
    
    label_0=zeros(j,1);
    label_1=ones(j,1);
    
    features=[features_0;features_1];
    labels=[label_0;label_1];
    save(['features/',zoom_list(i).name(1:len-4),'.mat'],'features','labels');
   

end


end