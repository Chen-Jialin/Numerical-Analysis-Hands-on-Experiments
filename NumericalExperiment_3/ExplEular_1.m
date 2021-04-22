close all;clear;clc;
h = 0.05;
x = 0:0.01:0.4;
y = 100;
analyticalsol = y * exp(-50 .* x);
figure(1);
plot(x,analyticalsol,'-','LineWidth',2);
hold on;
x = 0:h:0.4;
analyticalsol = y * exp(-50 .* x);
for i = x(1:end - 1)
    y(end + 1) = y(end) + h * (-50 * y(end));
end
plot(x,y,'.','MarkerSize',20);
grid on;
xlabel('x');
ylabel('y');
legend('解析解 y=100e^{-50x}','数值解','Interpreter','tex');
figure(2);
plot(1:size(x,2) - 1,abs(y(2:end) - analyticalsol(2:end)),'-','LineWidth',2);
grid on;
xlabel('迭代次数 n');
ylabel('误差绝对值 |\epsilon_n|','Interpreter','tex');