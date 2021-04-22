close,clear,clc;
x = -1:0.01:1;
plot(x,f(x),'--');
hold on;
plot(x,P_4(x));
axis square;
delta = @(x)(f(x) - P_4(x)).^2;
n = 200;
I = 0;
for i = 0:(n - 1)
    I = I + 2 / (6 * n) * (delta(-1 + 2 * i / n) + 4 * delta(-1 + 2 * (i + 1 / 2) / n) + delta(-1 + 2 * (i + 1) / n));
end
I = sqrt(I);
function y = f(x)
    y = 1 ./ (1 + 25 * x.^2);
end
function y = P_4(x)
    y = 3 * (-1610 + 2797 * atan(5)) / 10000 - 21 * (-180 + 211 * atan(5)) / 1000 * x.^2 + 21 * (-370 + 399 * atan(5)) / 2000 * x.^4;
end