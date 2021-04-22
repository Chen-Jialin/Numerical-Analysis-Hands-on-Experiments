close all;clear;clc;
h = 0.02;
epsilon = 10^(-6);
t = 0:h:1000;
yz = [pi / 3;-1 / 2]; 
for i = t(1:end - 1)
    y0 = yz(1,end) + h * yz(2,end);
    z0 = yz(2,end) - h * sin(yz(1,end));
    y = yz(1,end) + h / 2 * (yz(2,end) + z0);
    z = yz(2,end) - h / 2 * (sin(yz(1,end)) + sin(y));
    while norm([y - y0;z - z0],inf) > epsilon
        y0 = y;
        z0 = z;
        y = yz(1,end) + h / 2 * (yz(2,end) + z0);
        z = yz(2,end) - h / 2 * (sin(yz(1,end)) + sin(y));
    end
    yz(:,end + 1) = [y;z];
end
plot(t,yz(1,:));
grid on;
xlabel('t');
ylabel('\theta','Interpreter','tex');