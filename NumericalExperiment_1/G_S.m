clear,clc;
h = 0.1;
N = 1 / h;
epsilon = 10^(-6);
C = diag(ones(N - 2,1),1) + diag(ones(N - 2,1),-1);
L_h = zeros((N - 1) * (N - 1),(N - 1) * (N - 1));
for i = 1:N - 1
    L_h((N - 1) * (i - 1) + 1:(N - 1) * i,(N - 1) * (i - 1) + 1:(N - 1) * i) = 4 * eye(N - 1) - C;
end
for i = 1:N - 2
    L_h((N - 1) * (i - 1) + 1:(N - 1) * i,(N - 1) * i + 1:(N - 1) * (i + 1)) = -eye(N - 1);
    L_h((N - 1) * i + 1:(N - 1) * (i + 1),(N - 1) * (i - 1) + 1:(N - 1) * i) = -eye(N - 1);
end
f_h = zeros((N - 1) * (N - 1),1);
for j = 1:N - 1
    for i = 1:N - 1
        f_h((N - 1) * (j - 1) + i) = f(h * i,h * j);
    end
end
tic
D = eye((N - 1) * (N - 1)) .* L_h;%L_h的对角矩阵
L = -(L_h - triu(L_h));%L_h的下三角矩阵
U = -(L_h - tril(L_h));%L_h的上三角矩阵
b = h^2 * f_h;
G = (D - L) \ U;%Jacobi矩阵
f1 = (D - L) \ b;
k = 0;%迭代次数
u_h_k = ones((N - 1) * (N - 1),1);
u_h_past = zeros((N - 1) * (N - 1),1);
while norm(u_h_k - u_h_past,Inf) > epsilon
    k = k + 1;
    u_h_past = u_h_k;
    u_h_k = G * u_h_past + f1;
end
toc
u_star = zeros((N - 1) * (N - 1),1);%精确解
for j = 1:N - 1
    for i = 1:N - 1
        u_star((N - 1) * (j - 1) + i) = sin(pi * h * i) * sin(pi * h * j);
    end
end
k
norm(u_h_k - u_star,1)
norm(u_h_k - u_star,2)
norm(u_h_k - u_star,Inf)
function y = f(x,y)
    y = 2 * pi^2 * sin(pi * x) * sin(pi * y);
end