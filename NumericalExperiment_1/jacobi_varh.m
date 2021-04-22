clear,clc;
h_list = [0.01 1/90 1/80 1/70 1/60 0.02 0.025 1/30 0.05 0.1 0.2];
k_list = [];
norm_list = [];
for h = h_list
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
    b = h^2 * f_h;
    J = eye((N - 1)^2) - L_h / 4;%Jacobi矩阵
    f1 = D \ b;
    k = 0;%迭代次数
    u_h_k = ones((N - 1) * (N - 1),1);
    u_h_past = zeros((N - 1) * (N - 1),1);
    while norm(u_h_k - u_h_past,Inf) > epsilon
        k = k + 1;
        u_h_past = u_h_k;
        u_h_k = J * u_h_past + f1;
    end
    toc
    u_star = zeros((N - 1) * (N - 1),1);%精确解
    for j = 1:N - 1
        for i = 1:N - 1
            u_star((N - 1) * (j - 1) + i) = sin(pi * h * i) * sin(pi * h * j);
        end
    end
    k_list(end + 1) = k;
    norm_list(end + 1,1) = norm(u_h_k - u_star,1);
    norm_list(end,2) = norm(u_h_k - u_star,2);
    norm_list(end,3) = norm(u_h_k - u_star,Inf);
end
h_list
k_list
norm_list
yyaxis left
plot(h_list,k_list,'bx');
xlabel('h');
ylabel('试验中求得的迭代次数');
hold on
h_range = 0.01:0.001:0.2;
yyaxis right
plot(h_range,1 ./ log(1 + 2 * sin(pi * h_range / 2).^2),'r-');
ylabel('理论上计算得到的迭代速度的倒数');
legend('试验中求得的迭代次数','理论上计算得到的迭代速度的倒数');
function y = f(x,y)
y = 2 * pi^2 * sin(pi * x) * sin(pi * y);
end