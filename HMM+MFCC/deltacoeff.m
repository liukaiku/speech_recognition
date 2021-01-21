function diff = deltacoeff(x)
%计算MFCC差分系数
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
% %调用deltacoeff函数计算MFCC差分系数
% d=deltacoeff(FMatrix);         %计算一阶差分系数
% d1=deltacoeff(d);              %计算二阶差分系数
% FMatrix=[FMatrix,d,d1];        %将三组数据作为特征向量
