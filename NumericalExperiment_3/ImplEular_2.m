close all;clear;clc;
h = 0.01;
t = 0:h:5;
yx = [3;2]; 
for i = t
    yx(:,end + 1) = inv(eye(2) - h * [0 -2;9/2 0]) * yx(:,end);
end
plot(yx(2,:),yx(1,:));
grid on;
axis equal;
xlabel('x');
ylabel('y');