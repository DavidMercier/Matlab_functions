%This code find all prime numbers
%upto the entered number
clear all;
%N=input('Prime Numbers until:');
N=200;
if N<2
    return;
elseif N==2
    disp(2);
    return;
end
Pr(1)=2;Pr(2)=3;Count=3;
for i=4:N
    C=Check(i);
    if C==1
        Pr(Count)=i;
        Count = Count +1;
    end
end
%disp(Pr);
PrSum(1) = 0;
PrSum(2) = 1;
for ii = 3:N
    PrSum(ii) = max(find(Pr<ii));
end

xData = 1:N;
stairs(xData,PrSum,'k'); hold on;

% Min bound
yData(:) = xData(:)./log(xData(:));
plot(xData, yData, '-r'); hold on;
legend('Prime Numbers Distribution', 'x/log(x)');

% Max bound
try
    yData2(:) = logint(xData(:));
    plot(xData, yData2, '-g');    
    legend('Prime Numbers Distribution', 'x/log(x)', 'Li(x)');
catch
end


function C=Check(i)
C=1;
for k=2:(ceil(sqrt(i)))
    if mod(i,k)==0
        C=0;
    end
end
end
