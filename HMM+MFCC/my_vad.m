function [x1,x2] =my_vad(x)

% Ԥ�����˲���
xx=double(x);
xx=filter([1 -0.9375],1,xx);
%���ȹ�һ����[-1,1]
xx = xx / max(abs(xx));

%��������
FrameLen = 256;
FrameInc = 100;
NIS=15;              %����ǰ�������ε�֡��Ϊ20�������Լ����ɼ���������һ����0.5s�������Σ�<30*200/16K=0.4s������

amp1 = 6;
% amp2 = 0.3;
amp2 = 0.15;
%zcr1 = 10;
zcr1 = 1;

maxsilence =60;    % 30*10ms  = 300ms�����Ĭʱ��������δ����maxsilence�ĳ��ȣ���ȻΪ������
minlen  = 30;      % 15*10ms = 150ms   ����������Ų�������
status  = 0;
count   = 0;
silence = 0;

amp=my_STEn(xx,FrameLen,FrameInc);
zcr=my_STZcr(xx,FrameLen,FrameInc);

ampth=mean(amp(1:NIS));                 % �����ʼ�޻������������͹����ʵ�ƽ��ֵ               
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
m_zcr=abs(zcr-zcrth_v);           % ÿ֡�������͹����ʶ���ȥǰ�涼�������ε���Ӧ����ֵ
                 
%���������
% tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
% tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
% signs = (tmp1.*tmp2)<0;
% diffs = (tmp1 -tmp2)>0.02;
% zcr   = sum(signs.*diffs, 2);
%�����ʱ����
%amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);

%������������
amp1 = min(amp1, max(m_amp)/5);           %������
amp2 = min(amp2, max(m_amp)/15);           %������
zcr2 = min(zcr1, max(m_zcr)/5);


%��ʼ�˵���
x1 = 0; 
x2 = 0;
for n=1:length(zcr) %֡��ѭ��
 %  goto = 0;
   switch status
   case {0,1}                   % 0 = ����, 1 = ���ܿ�ʼ
      if amp(n) > amp1         % ȷ�Ž���������
         
%       if amp(n) > amp1   | ...        % ȷ�Ž���������
%           zcr(n) > zcr2     
         x1 = max(n-count-1,1);
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... % ���ܴ���������
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                       % ����״̬
         status  = 0;
         count   = 0;
      end
   case 2,                       % 2 = ������
      if amp(n) > amp2 | ...     % ������������
         zcr(n) > zcr2
         count = count + 1;
      else                       % ����������
         silence = silence+1;
         if silence < maxsilence % ����������������δ����
            count  = count + 1;
         elseif count < minlen   % ��������̫�̣���Ϊ������
            status  = 0;
            silence = 0;
            count   = 0;
         else                    % ��������
            status  = 3;
         end
      end
   case 3,
      break;
   end
end   

count =count-silence/1.2;                                                   %���ݾ����趨�ĳ��ȣ�silence/3Ҳ����
x2 = x1+count-1;                                                        %x1,x2Ϊ��������ֹ֡��
% inc=FrameInc;

