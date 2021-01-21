function diff = deltacoeff(x)
%����MFCC���ϵ��
[nr,nc]=size(x);
N=2;
diff=zeros(nr,nc);
for t=3:nr-2
    for n=1:N
    diff(t,:)=diff(t,:)+n*(x(t+n,:)-x(t-n,:));
    end
    diff(t,:)=diff(t,:)/10;       %10=2*(1^2+2^2)
end

% 
% 
% %����deltacoeff��������MFCC���ϵ��
% d=deltacoeff(FMatrix);         %����һ�ײ��ϵ��
% d1=deltacoeff(d);              %������ײ��ϵ��
% FMatrix=[FMatrix,d,d1];        %������������Ϊ��������
