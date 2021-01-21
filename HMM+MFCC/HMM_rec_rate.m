clear all;
close all;
ncoeff = 24;          %Mel滤波器个数
N =8;               %要匹配的模板数，
M=25; %****************************************************目前只有24个待测样本，以后可以继续扩展
% rMatrix = cell(1,M);                                                      %定义一个细胞数组***存放26个待测样本的MFCC值*******************
right=0;
wrong=0;
total=0;
load hmm_model.mat; %**********************************载入已经训练好的hmm模型，即可进行匹配


%关冰箱
for j=1:M
    q = ['G:\毕业设计\实验模式匹配\实验DTW\测试数据\关灯\' num2str(j) '.wav'];
    [speechIn,fs]=wavread(q);
    rec_fea = my_mfcc(speechIn,fs,ncoeff);
    
for i = 1:N           %********************与8个hmm模型进行匹配，求取最大概率                                               %读取26人的测试样本        
    pxsm(i) = viterbi(hmm{i}, rec_fea); 
end

[d,n] = max(pxsm); % 判决，将该最大值对应的序号作为识别结果    
    if(n==2)
        right=right+1
    else
        wrong=wrong+1
    end  
    total=right+wrong
end
rec_rate=right/total



% fprintf('该语音识别结果为%d\n',n)
% Word = char('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26');
% for j=1:M                                                               
% rMatrix1=rMatrix{1,j};
% rMatrix2 =CMN(rMatrix1);                         %归一化处理                    
% Sco = my_DTWScores(rMatrix2,N) ;                   %计算DTW值                             %得到的是 8行*11列 的矩阵，即与88个模板间的最短距离
% [SortedScores,EIndex] = sort(Sco,2) ;          %按行递增排序，对每一行分别进行排序，得到的第一列是最小值        %求取88个距离中的最小值
% Nbr = SortedScores(:,1:3) ;                %取前3列，后面对每一行值累加，看谁最小，得到最小距离最短，即得出结果。得到每个模板匹配的3个最低值对应的次序
% %怎样在原距离矩阵中找到与最短距离对应的下标
% % [r,c]=size(Nbr); %8行*3列
% dis=sum(Nbr,2);
% [sorted_dis,ind]=sort(dis);
% 
% % fprintf('第 %s 个样本已测试完毕.\n',Word(j)); 
% 
% result=ind(1); 
% if(result==7)                                                              %****************************** result=？ 要与口令一致做相应的改正***************88
%     corr=corr+1
%     err=err
% else
%     err=err+1
%     corr=corr
% end    
% all=err+corr
% end      
% 
% rate_recongition=corr/all
% 
% 
% 
% 
% 
% 
% [speechIn,fs,bit]=wavread('关空调.wav');
% rec_fea = my_mfcc(speechIn,fs,24); 
% 
% % rec_fea = mfcc(rec_sph);  % 特征提取
% % 求出当前语音关于各数字hmm的p(X|M)
% 
