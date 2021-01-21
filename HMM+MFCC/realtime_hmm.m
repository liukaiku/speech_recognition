clear all;
close all;
load hmm_model.mat; %**********************************载入已经训练好的hmm模型，即可进行匹配
ncoeff = 24;          %Mel滤波器个数
N = 16;               %每个模板中的词汇数，即11条口令
fs=16000;             %采样频率                
duration2 = 2;        %录音时长
% k = 11;                %训练样本的人数

speech = audiorecorder(fs,16,1);                                            %16k采样率，16bit量化，1个声道
disp('Press any key to start 2 seconds of speech recording...'); 
pause
disp('Recording speech...'); 
recordblocking(speech,duration2)             % duration*fs 为采样点数 
speechIn=getaudiodata(speech);
disp('Finished recording.');
disp('System is trying to recognize what you have spoken...');
%speechIn = my_vad(speechIn);                    %端点检测 
% rMatrix1 = my_mfcc(speechIn,fs,ncoeff);            %采用MFCC系数作为特征矢量,帧数*（12维+差分的一维）
% [speechIn,fs,bit]=wavread('开冰箱.wav');
rec_fea = my_mfcc(speechIn,fs,ncoeff); 

% rec_fea = mfcc(rec_sph);  % 特征提取
% 求出当前语音关于各数字hmm的p(X|M)
for i=1:8
  pxsm(i) = viterbi(hmm{i}, rec_fea); 
end
[d,n] = max(pxsm); % 判决，将该最大值对应的序号作为识别结果
% fprintf('该语音识别结果为%d\n',n)
switch n
    case 1
        fprintf('该语音识别结果为:关冰箱\n');
    case 2
        fprintf('该语音识别结果为:关灯\n');
    case 3
        fprintf('该语音识别结果为:关空调\n');
    case 4
        fprintf('该语音识别结果为:关门\n');
    case 5
        fprintf('该语音识别结果为:开冰箱\n');
    case 6 
        fprintf('该语音识别结果为:开灯\n');
    case 7
        fprintf('该语音识别结果为:开空调\n');
    case 8
        fprintf('该语音识别结果为:开门\n');
end