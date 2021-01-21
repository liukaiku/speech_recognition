clear all;
close all;
load hmm_model.mat; %**********************************�����Ѿ�ѵ���õ�hmmģ�ͣ����ɽ���ƥ��
ncoeff = 24;          %Mel�˲�������
N = 16;               %ÿ��ģ���еĴʻ�������11������
fs=16000;             %����Ƶ��                
duration2 = 2;        %¼��ʱ��
% k = 11;                %ѵ������������

speech = audiorecorder(fs,16,1);                                            %16k�����ʣ�16bit������1������
disp('Press any key to start 2 seconds of speech recording...'); 
pause
disp('Recording speech...'); 
recordblocking(speech,duration2)             % duration*fs Ϊ�������� 
speechIn=getaudiodata(speech);
disp('Finished recording.');
disp('System is trying to recognize what you have spoken...');
%speechIn = my_vad(speechIn);                    %�˵��� 
% rMatrix1 = my_mfcc(speechIn,fs,ncoeff);            %����MFCCϵ����Ϊ����ʸ��,֡��*��12ά+��ֵ�һά��
% [speechIn,fs,bit]=wavread('������.wav');
rec_fea = my_mfcc(speechIn,fs,ncoeff); 

% rec_fea = mfcc(rec_sph);  % ������ȡ
% �����ǰ�������ڸ�����hmm��p(X|M)
for i=1:8
  pxsm(i) = viterbi(hmm{i}, rec_fea); 
end
[d,n] = max(pxsm); % �о����������ֵ��Ӧ�������Ϊʶ����
% fprintf('������ʶ����Ϊ%d\n',n)
switch n
    case 1
        fprintf('������ʶ����Ϊ:�ر���\n');
    case 2
        fprintf('������ʶ����Ϊ:�ص�\n');
    case 3
        fprintf('������ʶ����Ϊ:�ؿյ�\n');
    case 4
        fprintf('������ʶ����Ϊ:����\n');
    case 5
        fprintf('������ʶ����Ϊ:������\n');
    case 6 
        fprintf('������ʶ����Ϊ:����\n');
    case 7
        fprintf('������ʶ����Ϊ:���յ�\n');
    case 8
        fprintf('������ʶ����Ϊ:����\n');
end