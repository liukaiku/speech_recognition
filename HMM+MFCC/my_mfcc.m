function ccc=my_mfcc(x,fs,p)
% x�������������У�Mel�˲����ĸ���Ϊp������Ƶ��Ϊfs��frameSizeΪ֡����FFT����
%����ͳһ����ֵ256��������incΪ֡��Ϊ100��������cccΪMFCC������

[x1,x2] =my_vad(x);                                           %xΪԭʼ��������

%frameSize=framelen;               %Ϊͳһ��֡��256
frameSize=256;                                   %frameSizeΪ֡����FFT����
inc=100;

% bank=melbankm(p,frameSize,fs);
% % framesize ��length of fft
% % ��һ��Mel�˲�����ϵ��
% bank=full(bank);
% bank=bank/max(bank(:));

%%-------׼������-------------
%��һ��mel�˲�����ϵ��(24����)
bank=melbankm2(p,frameSize,fs,0,0.5,'m'); 
bank=full(bank);
bank=bank/max(bank(:));

% DCTϵ��,12*p
for k=1:12
  n=0:p-1;
  dctcoef(k,:)=cos((2*n+1)*k*pi/(2*p));
end
% ��һ��������������
w = 1 + 6 * sin(pi * [1:12] ./ 12);
w = w/max(w);

% �����źŷ�֡
xx=my_enframe(x,frameSize,inc);  %��Ҫ�ٴη�֡��ʹ������
n2= fix(frameSize/2) +1 ;                    %����֡���ȵ�һ��
xx=xx(x1:x2,:);
% ����ÿ֡��MFCC����
for i=1:(x2-x1+1)    %x1,x2ֻ��֡���±�                                                  %֡����ѭ��
  y = xx(i,:);
  s = y' .* hamming(frameSize);
  t = abs(fft(s));
  t = t.^2;
  c1=dctcoef * log(bank * t(1:n2));
  c2 = c1.*w';
  m(i,:)=c2';                                                              %ÿһ�д���ÿһ֡��ÿһ֡����12������
end

ccc=m;

% %���ϵ��
% dtm = zeros(size(m));                       %  ֡��*12�ľ���
% for i=3:size(m,1)-2
%   dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
% end
% dtm = dtm / 3;
% %�ϲ�MFCC������һ�ײ��MFCC����
% ccc = [m dtm];                              %��m�ĺ����ٽ�һ�����󣬹��γ���  ֡��*24�Ĳ�������
% %ȥ����β��֡����Ϊ����֡��һ�ײ�ֲ���Ϊ0
% ccc = ccc(3:size(m,1)-2,:);

