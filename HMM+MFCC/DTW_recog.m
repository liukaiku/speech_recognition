load DTW_model.mat; %**********************************载入已经训练好的hmm模型，即可进行匹配
[speechIn,bit]=audioread('关门.wav');
rec_fea = my_mfcc(speechIn,fs,24); 

 %rec_fea = mfcc(rec_sph);  % 特征提取
% 求出当前语音关于各数字hmm的p(X|M)
for i=1:8
  pxsm(i) = viterbi(hmm{i}, rec_fea); 
end
[d,n] = max(pxsm); % 判决，将该最大值对应的序号作为识别结果
% fprintf('该语音识别结果为%d\n',n)
switch n
    case 1
        fprintf('该语音识别结果为关冰箱\n');
    case 2
        fprintf('该语音识别结果为关灯\n');
    case 3
        fprintf('该语音识别结果为关空调\n');
    case 4
        fprintf('该语音识别结果为关门\n');
    case 5
        fprintf('该语音识别结果为开冰箱\n');
    case 6 
        fprintf('该语音识别结果为开灯\n');
    case 7
        fprintf('该语音识别结果为开空调\n');
    case 8
        fprintf('该语音识别结果为开门\n');
end