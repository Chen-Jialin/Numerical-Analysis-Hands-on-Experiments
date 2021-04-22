close,clear,clc;
t = (1960:1968)';% time (year)
N = [29.72;30.61;31.51;32.13;32.34;32.85;32.56;34.20;34.83];% population
y = log(N);
A = ones(9,2);% coefficient matrix of overdetermined equation system
A(:,2) = t;
ATA = A' * A;% coefficient matrix of normal equation system
ATb = A' * y;% right vector of normal equation system
ab = ATA \ ATb;
N_2018 = exp(ab(1) + ab(2) * 2018);% population in 2018
N_2019 = exp(ab(1) + ab(2) * 2019);% population in 2019
plot(t,N,'--');
hold on;
plot(t,exp(ab(1) + ab(2) * t));
grid on;
title('The fitting of World Population with Least Square Method','Interpreter','latex');
xlabel('time $t/$year','Interpreter','latex');
ylabel('World Population $N/$hundred million person(s)','Interpreter','latex');
legend('Original data','Fitting World Population')