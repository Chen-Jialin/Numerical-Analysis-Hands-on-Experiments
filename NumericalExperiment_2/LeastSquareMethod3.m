close,clear,clc;
t = [1,11,22,31,41,51,53,62,72]';% time (day)
N = [297,1584,1640,1988,2189,2309,2319,2394,2439]';% case number
A = ones(9,2);% coefficient matrix of overdetermined equation system
A(:,2) = 1 ./ t;
ATA = A' * A;% coefficient matrix of normal equation system
ATb = A' * (1 ./ N);% right vector of normal equation system
ab = ATA \ ATb;
N_5dlater = 1 / (ab(1) + ab(2) / (t(end) + 5));% Case number 5 days later
plot(t,N,'--');
hold on;
plot([t;t(end) + 5],[1 ./ (ab(1) + ab(2) ./ t);N_5dlater]);
grid on;
title('The fitting of Case Number with Least Square Method','Interpreter','latex');
xlabel('time $t/$day(s)','Interpreter','latex');
ylabel('Case Number $N/$person(s)','Interpreter','latex');
legend('Original data','Fitting case number')