function [x1,x2] =my_vad(x)

% 预加重滤波器
xx=double(x);
xx=filter([1 -0.9375],1,xx);
%幅度归一化到[-1,1]
xx = xx / max(abs(xx));

%常数设置
FrameLen = 256;
FrameInc = 100;
NIS=15;              %设置前面无声段的帧数为20，根据自己所采集的样本，一般有0.5s的无声段，<30*200/16K=0.4s，可行

amp1 = 6;
% amp2 = 0.3;
amp2 = 0.15;
%zcr1 = 10;
zcr1 = 1;

maxsilence =60;    % 30*10ms  = 300ms，最大静默时长，即，未超过maxsilence的长度，仍然为有声段
minlen  = 30;      % 15*10ms = 150ms   ，用来检测排查噪声的
status  = 0;
count   = 0;
silence = 0;

amp=my_STEn(xx,FrameLen,FrameInc);
zcr=my_STZcr(xx,FrameLen,FrameInc);

ampth=mean(amp(1:NIS));                 % 计算初始无话段区间能量和过零率的平均值               
zcrth=mean(zcr(1:NIS));

ampth_v=zeros(1,length(zcr));
for i=1:length(zcr)
   ampth_v(i)=ampth;
end
zcrth_v=zeros(1,length(zcr));
for j=1:length(zcr)
   zcrth_v(j)=zcrth;
end
m_amp=abs(amp-ampth_v);
m_zcr=abs(zcr-zcrth_v);           % 每帧的能量和过零率都减去前面都是噪声段的相应的数值
                 
%计算过零率
% tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
% tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
% signs = (tmp1.*tmp2)<0;
% diffs = (tmp1 -tmp2)>0.02;
% zcr   = sum(signs.*diffs, 2);
%计算短时能量
%amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);

%调整能量门限
amp1 = min(amp1, max(m_amp)/5);           %高门限
amp2 = min(amp2, max(m_amp)/15);           %低门限
zcr2 = min(zcr1, max(m_zcr)/5);


%开始端点检测
x1 = 0; 
x2 = 0;
for n=1:length(zcr) %帧数循环
 %  goto = 0;
   switch status
   case {0,1}                   % 0 = 静音, 1 = 可能开始
      if amp(n) > amp1         % 确信进入语音段
         
%       if amp(n) > amp1   | ...        % 确信进入语音段
%           zcr(n) > zcr2     
         x1 = max(n-count-1,1);
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... % 可能处于语音段
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                       % 静音状态
         status  = 0;
         count   = 0;
      end
   case 2,                       % 2 = 语音段
      if amp(n) > amp2 | ...     % 保持在语音段
         zcr(n) > zcr2
         count = count + 1;
      else                       % 语音将结束
         silence = silence+1;
         if silence < maxsilence % 静音还不够长，尚未结束
            count  = count + 1;
         elseif count < minlen   % 语音长度太短，认为是噪声
            status  = 0;
            silence = 0;
            count   = 0;
         else                    % 语音结束
            status  = 3;
         end
      end
   case 3,
      break;
   end
end   

count =count-silence/1.2;                                                   %根据经验设定的长度，silence/3也可以
x2 = x1+count-1;                                                        %x1,x2为语音的起止帧号
% inc=FrameInc;

