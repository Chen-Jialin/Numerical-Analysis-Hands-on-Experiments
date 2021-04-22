close,clear,clc;
for n = 2:2:8% the number of the nodes
    x = 2 / n * (0:n)' - 1;% the nodes
    L = @(t)L_n(t,x);% lagrange interpolation polynomial corresponding to the nodes
    t = -1:0.01:1;
    %subplot(2,2,floor((n / 2 - 1) / 2) + 2 * mod(n / 2 - 1,2) + 1);
    figure(n / 2);
    plot(t,f(t),'--');
    hold on;
    plot(t,L(t));
    axis square
    ylim([-1,1]);
    title([num2str(n),'-th order Lagrange interpolation polynomial of $f(x)=\frac{1}{1+25x^2}$'],'Interpreter','LaTeX')
    xlabel('x');
    ylabel('y');
    legend('The original function',['The ',num2str(n),'-th order Lagrange interpolation polynomial']);
end

function y = f(x)
y = 1 ./ (1 + 25 * x.^2);
end
function y = L_n(t,x)
n = size(x,1) - 1;
y = 0;
for i = 0:n
    l_i = f(x(i + 1));
    for j = 0:n
        if j ~= i
            l_i = l_i .* (t - x(j + 1)) / (x(i + 1) - x(j + 1));
        end
    end
    y = y + l_i;
end
end