%This code find all prime numbers
%upto the entered number
clear all;
close all;

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
h1 = stairs(xData,PrSum,'k'); hold on;

% Min bound
yData(:) = xData(:)./log(xData(:));
h2 = plot(xData, yData, '-r'); hold on;
legend('Prime Numbers Distribution', 'x/log(x)');

% Max bound
try
    yData2(:) = logint(xData(:));
    h3 = plot(xData, yData2, '-g');
    legend('Prime Numbers Distribution', 'x/log(x)', 'Li(x)');
catch
end

% Riemann
try
    yData3(:) = J_RiemannPrimeCount(xData(:));
    h3 = plot(xData, yData3, '-g');
    legend('Prime Numbers Distribution', 'x/log(x)', 'Li(x)');
catch
end

% Plot settings
set([h1, h2], 'Linewidth', 2);

function C=Check(i)
C=1;
for k=2:(ceil(sqrt(i)))
    if mod(i,k)==0
        C=0;
    end
end
end

% Explicit Riemann Prime Counting function J
function J_RiemannPrimeCount = J(x)
if x < 2
    error("x must be >= 2");
end
integral_fun = @(t) (1 ./ (t.*(t.^2-1).*log(t)));
integral_term = integral(integral_fun,x,Inf);

zetaZeros = 0.5 + csvread("first 100k zeros of the Riemann zeta.txt") .* 1i;
maxZero = 35;
k = 1:1:maxZero;
Li_term = logint(x.^zetaZeros(k)) - logint(2);
Li_sum = sum(Li_term);

J_RiemannPrimeCount = (logint(x) - logint(2)) - Li_sum - log(2) + integral_term;
end