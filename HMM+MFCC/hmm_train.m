clear all;
% % ����ѵ�����ݼ�tra_data.mat
% load t_data.mat;
% ����ģ������
% load('t_data.mat');
% train_data = struct2cell(s1);
%**********************  ѡ��ģ�彫ԭʼ�������ݱ�����  train_data ��
%cell��1��8�����У�ÿ��cell����cell��1��16��

                                                                              
train_data=cell(1,8);%**************�������8��cell��ֵ����     
% 
% fMatrix1 = cell(1,16);
% fMatrix2 = cell(1,16);
% fMatrix3 = cell(1,16);
% fMatrix4 = cell(1,16);
% fMatrix5 = cell(1,16);
% fMatrix6 = cell(1,16);
% fMatrix7 = cell(1,16);
% fMatrix8 = cell(1,16);
%****************************************ȡ10 ������ѵ���ɣ�16����ʱ��̫����
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
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\�ر���\' num2str(i) '.wav'];
    [speechIn1,FS1] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix1(1,i) = {speechIn1};                    % ncoeffӦΪmel�˲����ĸ���        
    kzx=kzx+1;
end

% for j = 1:16
for j = 1:19
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\�ص�\' num2str(j) '.wav'];
    [speechIn2,FS2] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix2(1,j) = {speechIn2}; 
      kzx=kzx+1;
end

% for k = 1:16
for k = 1:19
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\�ؿյ�\' num2str(k) '.wav'];
    [speechIn3,FS3] = audioread(q);
   % speechIn3 = my_vad(speechIn3); 
    fMatrix3(1,k) = {speechIn3};
      kzx=kzx+1;
end

% for i = 1:16
for i = 1:19
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\����\' num2str(i) '.wav'];
    [speechIn4,FS4] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix4(1,i) = {speechIn4};                     
      kzx=kzx+1;
end

% for j = 1:16
for j = 1:19
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\������\' num2str(j) '.wav'];
    [speechIn5,FS5] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix5(1,j) = {speechIn5}; 
      kzx=kzx+1;
end

% for k = 1:16
for k = 1:19
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\����\' num2str(k) '.wav'];
    [speechIn6,FS6] = audioread(q);
   % speechIn3 = my_vad(speechIn3); 
    fMatrix6(1,k) = {speechIn6};
      kzx=kzx+1;
end

% for i = 1:16
for i = 1:19
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\���յ�\' num2str(i) '.wav'];
    [speechIn7,FS7] = audioread(q);
   % speechIn1 = my_vad(speechIn1); 
    fMatrix7(1,i) = {speechIn7};                       
      kzx=kzx+1;
end

% for j = 1:16
for j = 1:19
     q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\ѵ������\����\' num2str(j) '.wav'];
    [speechIn8,FS8] = audioread(q);
   % speechIn2 = my_vad(speechIn2); 
    fMatrix8(1,j) = {speechIn8}; 
      kzx=kzx+1;
end
train_data(1,:)={fMatrix1 ,fMatrix2, fMatrix3, fMatrix4, fMatrix5, fMatrix6, fMatrix7, fMatrix8};


N = 4;   % hmm��״̬��
M = [3,3,3,3]; % ÿ��״̬��Ӧ�Ļ��ģ�ͳɷ���

for i = 1:length(train_data)  % ���ֵ�ѭ��      %*************************  load ֮�������tdata��1*10 ��cell����10������0~9������ÿ��cell��������8�����ݣ����ɼ���8���ˣ�ѵ��8��  
    %***********************************************��Ҫ����һ��
    %8*16%��cell���飬8�����ѵ��16��
    fprintf('\n�����%d�������mfcc��������\n',i);
    for k = 1:length(train_data{i})  % ��������ѭ��
      obs(k).sph = train_data{i}{k};  % ����i�ĵ�k������
       %my_mfcc(speechIn,Fs,ncoeff),16k sample_rate,24��mel�˲�������
      obs(k).fea = my_mfcc(obs(k).sph,16000,24);  % ��������ȡmfcc��������
    end    
    fprintf('\nѵ������%d��hmm\n',i);
    hmm_temp=inithmm(obs,N,M); %��ʼ��hmmģ��
    hmm{i}=baum_welch(hmm_temp,obs); %��������hmm�ĸ�����
end
save hmm_model.mat hmm                 %*****************************************�����ѵ���õ�hmm������ػ�ʱ���ݶ�ʧ����Ҫ�ظ�ѵ��
fprintf('\nѵ����ɣ�\n');


