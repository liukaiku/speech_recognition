clear all;
% % 读入训练数据集tra_data.mat
% load t_data.mat;
% 加载模板数据
% load('t_data.mat');
% train_data = struct2cell(s1);
%**********************  选择模板将原始语音数据保存在  train_data （
%cell（1，8））中，每个cell又是cell（1，16）

                                                                              
train_data=cell(1,8);%**************将下面的8个cell赋值给它     
% 
% fMatrix1 = cell(1,16);
% fMatrix2 = cell(1,16);
% fMatrix3 = cell(1,16);
% fMatrix4 = cell(1,16);
% fMatrix5 = cell(1,16);
% fMatrix6 = cell(1,16);
% fMatrix7 = cell(1,16);
% fMatrix8 = cell(1,16);
%****************************************取10 个进行训练吧，16个用时间太长了
fMatrix1 = cell(1,19);
fMatrix2 = cell(1,19);
fMatrix3 = cell(1,19);
fMatrix4 = cell(1,19);
fMatrix5 = cell(1,19);
fMatrix6 = cell(1,19);
fMatrix7 = cell(1,19);
fMatrix8 = cell(1,19);

kzx=0;
% for i = 1:16
for i = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关冰箱\' num2str(i) '.wav'];
    [speechIn1,FS1] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix1(1,i) = {speechIn1};                    % ncoeff应为mel滤波器的个数        
    kzx=kzx+1;
end

% for j = 1:16
for j = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关灯\' num2str(j) '.wav'];
    [speechIn2,FS2] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix2(1,j) = {speechIn2}; 
      kzx=kzx+1;
end

% for k = 1:16
for k = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关空调\' num2str(k) '.wav'];
    [speechIn3,FS3] = audioread(q);
   % speechIn3 = my_vad(speechIn3); 
    fMatrix3(1,k) = {speechIn3};
      kzx=kzx+1;
end

% for i = 1:16
for i = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关门\' num2str(i) '.wav'];
    [speechIn4,FS4] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix4(1,i) = {speechIn4};                     
      kzx=kzx+1;
end

% for j = 1:16
for j = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开冰箱\' num2str(j) '.wav'];
    [speechIn5,FS5] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix5(1,j) = {speechIn5}; 
      kzx=kzx+1;
end

% for k = 1:16
for k = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开灯\' num2str(k) '.wav'];
    [speechIn6,FS6] = audioread(q);
   % speechIn3 = my_vad(speechIn3); 
    fMatrix6(1,k) = {speechIn6};
      kzx=kzx+1;
end

% for i = 1:16
for i = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开空调\' num2str(i) '.wav'];
    [speechIn7,FS7] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix7(1,i) = {speechIn7};                       
      kzx=kzx+1;
end

% for j = 1:16
for j = 1:19
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开门\' num2str(j) '.wav'];
    [speechIn8,FS8] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix8(1,j) = {speechIn8}; 
      kzx=kzx+1;
end
train_data(1,:)={fMatrix1 ,fMatrix2, fMatrix3, fMatrix4, fMatrix5, fMatrix6, fMatrix7, fMatrix8};


N = 4;   % hmm的状态数
M = [3,3,3,3]; % 每个状态对应的混合模型成分数

for i = 1:length(train_data)  % 数字的循环      %*************************  load 之后会生成tdata，1*10 的cell，即10条口令0~9；其中每个cell里面又有8个数据，即采集了8个人，训练8次  
    %***********************************************我要建立一个
    %8*16%的cell数组，8个口令，训练16次
    fprintf('\n计算第%d条口令的mfcc特征参数\n',i);
    for k = 1:length(train_data{i})  % 样本数的循环
      obs(k).sph = train_data{i}{k};  % 数字i的第k个语音
       %my_mfcc(speechIn,Fs,ncoeff),16k sample_rate,24个mel滤波器个数
      obs(k).fea = my_mfcc(obs(k).sph,16000,24);  % 对语音提取mfcc特征参数
    end    
    fprintf('\n训练数字%d的hmm\n',i);
    hmm_temp=inithmm(obs,N,M); %初始化hmm模型
    hmm{i}=baum_welch(hmm_temp,obs); %迭代更新hmm的各参数
end
save hmm_model.mat hmm                 %*****************************************保存好训练好的hmm，避免关机时数据丢失，而要重复训练
fprintf('\n训练完成！\n');


