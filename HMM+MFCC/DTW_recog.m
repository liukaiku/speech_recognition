load DTW_model.mat; %**********************************�����Ѿ�ѵ���õ�hmmģ�ͣ����ɽ���ƥ��
[speechIn,bit]=audioread('����.wav');
rec_fea = my_mfcc(speechIn,fs,24); 

 %rec_fea = mfcc(rec_sph);  % ������ȡ
% �����ǰ�������ڸ�����hmm��p(X|M)
for i=1:8
  pxsm(i) = viterbi(hmm{i}, rec_fea); 
end
[d,n] = max(pxsm); % �о����������ֵ��Ӧ�������Ϊʶ����
% fprintf('������ʶ����Ϊ%d\n',n)
switch n
    case 1
        fprintf('������ʶ����Ϊ�ر���\n');
    case 2
        fprintf('������ʶ����Ϊ�ص�\n');
    case 3
        fprintf('������ʶ����Ϊ�ؿյ�\n');
    case 4
        fprintf('������ʶ����Ϊ����\n');
    case 5
        fprintf('������ʶ����Ϊ������\n');
    case 6 
        fprintf('������ʶ����Ϊ����\n');
    case 7
        fprintf('������ʶ����Ϊ���յ�\n');
    case 8
        fprintf('������ʶ����Ϊ����\n');
end