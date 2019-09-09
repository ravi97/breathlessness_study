function []=extract_sentences()
    
[gong,Fs]=audioread('gong.wav');
gong=gong(:,1);

[s,Fs]=audioread('prakhar_20_M_188_80_part1.wav');
s=s(:,1);

time=Fs*60;
s1=s(1:time);

[cor,delay]=xcorr(s1,gong);
delay=delay';
[~,ind]=max(cor);
start_time=delay(ind)/Fs;

f_id=fopen('Prakhar_20_m_188_80exact_start_stop_part1.txt');
timings=textscan(f_id,'%f %f %s\n');
timings=cell2mat(timings(1:2));
timings=(timings+start_time)*Fs;

mkdir('Test');
cd Test;
for i=1:size(timings,1)
    sen=s(round(timings(i,1)):round(timings(i,2)));
    audiowrite(strcat(int2str(i),'.wav'),sen,Fs);
    
end
cd ..;






end