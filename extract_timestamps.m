function []=extract_sentences()
    
[gong,Fs]=audioread('gong.wav');
gong=gong(:,1);

zoom_list=dir('zoom');
mkdir('modified_timestamps');

for i=3:size(zoom_list,1)
    
    [s,Fs]=audioread(['zoom/',zoom_list(i).name]);
    time=Fs*180;
    s=s(1:time,1);

    [cor,delay]=xcorr(s,gong);
    delay=delay';
    [~,ind]=max(cor);
    start_time=delay(ind)/Fs;
    
    len=length(zoom_list(i).name);
    ts_file=[zoom_list(i).name(1:len-10),'exact_start_stop_',zoom_list(i).name(len-8:len-4),'.txt'];
    f_id=fopen(['timestamp/',ts_file]);
    timings=textscan(f_id,'%f %f %s\n');
    timings=cell2mat(timings(1:2));
    timings=timings+start_time;
    fclose(f_id);
    
    fid=fopen(['modified_timestamps/',ts_file],'wt') ;
    for j=1:size(timings,1)
        fprintf(fid,'%f %f sentence%d\n',timings(j,1),timings(j,2),j);
    
    end
    fclose(fid);

end

end