%Script to run Monte Carlo estimator and plot asymptotic confidence
%intervals
clear all
close all
%Simulation parameters
alpha = 0.95;
h=@(u)u;
N = 2.^(8:16);

%Initaliazing random seed and matrices to store results
rng(123456);
sample_means = zeros(1,length(N));
sample_variances = zeros(1,length(N));
CI_CLT = zeros(2,length(N));
CI_Cb = zeros(2,length(N));

%Run MC estimation for each N and save results
for n = 1:length(N)
    [E_N, V_N, I_CLT, I_Cb] = MCEstimatorCI(h, N(n), alpha);
    sample_means(n) = E_N;
    sample_variances(n) = V_N;
    CI_CLT(:,n) = I_CLT;
    CI_Cb(:,n) = I_Cb;
end

%Plotting results
mu = 1/2;
lines = loglog(N, [mu*ones(1,length(N)); sample_means; CI_CLT; CI_Cb], 'LineWidth', 2);
%Set the same line colors for the confidence intervals and adjust the
%legend
set(lines, {'Color'}, {'k'; 'b'; 'g'; 'g'; 'r'; 'r'});
set(lines, {'LineStyle'}, {'-'; '-'; '-.'; '-.'; '-.'; '-.'});
legend([lines(1) lines(2) lines(3) lines(5)], {'\mu', 'MC estimator E_N', 'CLT bounds', 'Chebyshev bounds'})
xlabel('Number of samples N')
ylabel('Estimates')
axis tight