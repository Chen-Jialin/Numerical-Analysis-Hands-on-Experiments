close all;clear;clc;
[T,YX] = ode45('f2',[0 10],[2;3]);
plot(YX(:,2),YX(:,1));
grid on;
axis equal;
xlabel('x');
ylabel('y');