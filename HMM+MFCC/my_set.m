%**********************  选择模板将原始语音数据保存在  train_data （
%cell（1，8））中，每个cell又是cell（1，16）

                                                                              
train_data=cell(1,8);%**************将下面的8个cell赋值给它     

fMatrix1 = cell(1,16);
fMatrix2 = cell(1,16);
fMatrix3 = cell(1,16);
fMatrix4 = cell(1,16);
fMatrix5 = cell(1,16);
fMatrix6 = cell(1,16);
fMatrix7 = cell(1,16);
fMatrix8 = cell(1,16);
kzx=0;
for i = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关冰箱\' num2str(i) '.wav'];
    [speechIn1,FS1] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix1(1,i) = {speechIn1};                    % ncoeff应为mel滤波器的个数        
    kzx=kzx+1
end

for j = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关灯\' num2str(j) '.wav'];
    [speechIn2,FS2] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix2(1,j) = {speechIn2}; 
      kzx=kzx+1
end

for k = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关空调\' num2str(k) '.wav'];
    [speechIn3,FS3] = audioread(q);
   % speechIn3 = my_vad(speechIn3); 
    fMatrix3(1,k) = {speechIn3};
      kzx=kzx+1
end

for i = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\关门\' num2str(i) '.wav'];
    [speechIn4,FS4] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix4(1,i) = {speechIn4};                     
      kzx=kzx+1
end

for j = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开冰箱\' num2str(j) '.wav'];
    [speechIn5,FS5] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix5(1,j) = {speechIn5}; 
      kzx=kzx+1
end

for k = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开灯\' num2str(k) '.wav'];
    [speechIn6,FS6] = audioread(q);
   % speechIn3 = my_vad(speechIn3); 
    fMatrix6(1,k) = {speechIn6};
      kzx=kzx+1
end

for i = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开空调\' num2str(i) '.wav'];
    [speechIn7,FS7] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix7(1,i) = {speechIn7};                       
      kzx=kzx+1
end

for j = 1:16
     q = ['G:\毕业设计\实验模式匹配\实验DTW\训练数据\开门\' num2str(j) '.wav'];
    [speechIn8,FS8] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix8(1,j) = {speechIn8}; 
      kzx=kzx+1
end
train_data(1,:)={fMatrix1 ,fMatrix2, fMatrix3, fMatrix4, fMatrix5, fMatrix6, fMatrix7, fMatrix8};
% save train_data.mat

% train_data(1,1)=fMatrix1;
% train_data(1,2)=fMatrix2;
% train_data(1,3)=fMatrix3;
% train_data(1,4)=fMatrix4;
% train_data(1,5)=fMatrix5;
% train_data(1,6)=fMatrix6;
% train_data(1,7)=fMatrix7;
% train_data(1,8)=fMatrix8;


%将数据保存为mat文件
% fields = {'cf','cl','ca','cd','of','ol','oa','od'};
% s1 = cell2struct(train_data, fields, 2);         %fields项作为行
%  save t_data.mat  -struct s1;
% 加载模板数据
% s1 = load('tra_data.mat');
% fMatrixall1 = struct2cell(s1);
% %将数据保存为mat文件
% fields = {'p1','p2','p3','p4','p5','p6','p7','p8','p9','p10','p11','p12','p13','p14','p15','p16'};
% s1 = cell2struct(fMatrix1, fields, 2);         %fields项作为行
% save Vectors1.mat -struct s1;
% s2 = cell2struct(fMatrix2, fields, 2);
% save Vectors2.mat -struct s2;
% s3 = cell2struct(fMatrix3, fields, 2);
% save Vectors3.mat -struct s3;
% s4 = cell2struct(fMatrix4, fields, 2);         %fields项作为行
% save Vectors4.mat -struct s4;
% s5 = cell2struct(fMatrix5, fields, 2);
% save Vectors5.mat -struct s5;
% s6 = cell2struct(fMatrix6, fields, 2);
% save Vectors6.mat -struct s6;
% s7 = cell2struct(fMatrix7, fields, 2);         %fields项作为行
% save Vectors7.mat -struct s7;
% s8 = cell2struct(fMatrix8, fields, 2);
% save Vectors8.mat -struct s8;
