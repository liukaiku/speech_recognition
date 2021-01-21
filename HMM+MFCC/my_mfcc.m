function ccc=my_mfcc(x,fs,p)
% x是输入语音序列，Mel滤波器的个数为p，采样频率为fs，frameSize为帧长和FFT点数
%即用统一的数值256，，，，inc为帧移为100，，，；ccc为MFCC参数。

[x1,x2] =my_vad(x);                                           %x为原始语音数据

%frameSize=framelen;               %为统一的帧长256
frameSize=256;                                   %frameSize为帧长和FFT点数
inc=100;

% bank=melbankm(p,frameSize,fs);
% % framesize ：length of fft
% % 归一化Mel滤波器组系数
% bank=full(bank);
% bank=bank/max(bank(:));

%%-------准备工作-------------
%归一化mel滤波器组系数(24个窗)
bank=melbankm2(p,frameSize,fs,0,0.5,'m'); 
bank=full(bank);
bank=bank/max(bank(:));

% DCT系数,12*p
for k=1:12
  n=0:p-1;
  dctcoef(k,:)=cos((2*n+1)*k*pi/(2*p));
end
% 归一化倒谱提升窗口
w = 1 + 6 * sin(pi * [1:12] ./ 12);
w = w/max(w);

% 语音信号分帧
xx=my_enframe(x,frameSize,inc);  %需要再次分帧，使用数据
n2= fix(frameSize/2) +1 ;                    %计算帧长度的一半
xx=xx(x1:x2,:);
% 计算每帧的MFCC参数
for i=1:(x2-x1+1)    %x1,x2只是帧的下标                                                  %帧数，循环
  y = xx(i,:);
  s = y' .* hamming(frameSize);
  t = abs(fft(s));
  t = t.^2;
  c1=dctcoef * log(bank * t(1:n2));
  c2 = c1.*w';
  m(i,:)=c2';                                                              %每一行代表每一帧，每一帧里有12个数据
end

ccc=m;

% %差分系数
% dtm = zeros(size(m));                       %  帧数*12的矩阵
% for i=3:size(m,1)-2
%   dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
% end
% dtm = dtm / 3;
% %合并MFCC参数和一阶差分MFCC参数
% ccc = [m dtm];                              %在m的后面再接一个矩阵，共形成了  帧数*24的参数矩阵
% %去除首尾两帧，因为这两帧的一阶差分参数为0
% ccc = ccc(3:size(m,1)-2,:);

