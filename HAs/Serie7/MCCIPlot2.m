%Script to run Monte Carlo estimator and plot asymptotic confidence
%intervals
clear all
close all
%Simulation parameters
alpha = 0.95;
h=@(u)u;
N = 2.^(8:16);
K = 1000;

%Initaliazing random seed and matrices to store results
rng(123456);
avg_error = zeros(1,length(N));
avg_var = zeros(1,length(N));
percentage_CLT = zeros(1,length(N));
percentage_Cb = zeros(1,length(N));
mu = 1/2;

for k = 1:K
%Run MC estimation for each N and save results
for n = 1:length(N)
    [E_N, V_N, I_CLT, I_Cb] = MCEstimatorCI(h, N(n), alpha);
    avg_error(n) = avg_error(n)+ abs(E_N-mu);
    avg_var(n) = avg_var(n)+ sqrt(V_N/N(n));
    percentage_CLT(n) = percentage_CLT(n) + and(mu>I_CLT(1),mu<I_CLT(2));
    percentage_Cb(n) = percentage_Cb(n) + and(mu>I_Cb(1), mu<I_Cb(2));
end
end

%Plotting average error and estimated RMSE
loglog(N, [avg_error/K; avg_var/K; N.^(-0.5)], 'LineWidth', 2);
xlabel('Number of samples N')
ylabel('Average error/estimated RMSE')
legend('average |E_n-\mu|','average (V_N/N)^{-1/2} \approx RMSE', 'N^{-1/2}')
axis tight

%Plotting percentages for confidence intervals
figure
loglog(N, [percentage_CLT/K; percentage_Cb/K], 'LineWidth', 2);
xlabel('Number of samples N')
ylabel('Percentage of \mu\in [a_N,b_N]')
legend('CLT confidence interval','Chebyshev confidence interval')
axis tight