clear all;
close all;
ncoeff = 24;          %Mel�˲�������
N =8;               %Ҫƥ���ģ������
M=25; %****************************************************Ŀǰֻ��24�������������Ժ���Լ�����չ
% rMatrix = cell(1,M);                                                      %����һ��ϸ������***���26������������MFCCֵ*******************
right=0;
wrong=0;
total=0;
load hmm_model.mat; %**********************************�����Ѿ�ѵ���õ�hmmģ�ͣ����ɽ���ƥ��


%�ر���
for j=1:M
    q = ['G:\��ҵ���\ʵ��ģʽƥ��\ʵ��DTW\��������\�ص�\' num2str(j) '.wav'];
    [speechIn,fs]=wavread(q);
    rec_fea = my_mfcc(speechIn,fs,ncoeff);
    
for i = 1:N           %********************��8��hmmģ�ͽ���ƥ�䣬��ȡ������                                               %��ȡ26�˵Ĳ�������        
    pxsm(i) = viterbi(hmm{i}, rec_fea); 
end

[d,n] = max(pxsm); % �о����������ֵ��Ӧ�������Ϊʶ����    
    if(n==2)
        right=right+1
    else
        wrong=wrong+1
    end  
    total=right+wrong
end
rec_rate=right/total



% fprintf('������ʶ����Ϊ%d\n',n)
% Word = char('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26');
% for j=1:M                                                               
% rMatrix1=rMatrix{1,j};
% rMatrix2 =CMN(rMatrix1);                         %��һ������                    
% Sco = my_DTWScores(rMatrix2,N) ;                   %����DTWֵ                             %�õ����� 8��*11�� �ľ��󣬼���88��ģ������̾���
% [SortedScores,EIndex] = sort(Sco,2) ;          %���е������򣬶�ÿһ�зֱ�������򣬵õ��ĵ�һ������Сֵ        %��ȡ88�������е���Сֵ
% Nbr = SortedScores(:,1:3) ;                %ȡǰ3�У������ÿһ��ֵ�ۼӣ���˭��С���õ���С������̣����ó�������õ�ÿ��ģ��ƥ���3�����ֵ��Ӧ�Ĵ���
% %������ԭ����������ҵ�����̾����Ӧ���±�
% % [r,c]=size(Nbr); %8��*3��
% dis=sum(Nbr,2);
% [sorted_dis,ind]=sort(dis);
% 
% % fprintf('�� %s �������Ѳ������.\n',Word(j)); 
% 
% result=ind(1); 
% if(result==7)                                                              %****************************** result=�� Ҫ�����һ������Ӧ�ĸ���***************88
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
% [speechIn,fs,bit]=wavread('�ؿյ�.wav');
% rec_fea = my_mfcc(speechIn,fs,24); 
% 
% % rec_fea = mfcc(rec_sph);  % ������ȡ
% % �����ǰ�������ڸ�����hmm��p(X|M)
% 
