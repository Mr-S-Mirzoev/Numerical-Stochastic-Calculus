% Richardson Extrapolatio: Black-Scholes model
clear all 
close all

% Simulation parameters and initialization
N=10:2:20; % number of refinement steps
M = N.^4;  % number of samples, yields balanced errors
T  = 1;    % final time
M_RMSE = 10; % number of samples for the RMSE
RMSE = zeros(M_RMSE, length(M)); % empty vector to hold errors

% Black-Scholes parameters and SDE coefficients
r = 0.01;
sigma = 0.1;
mu_fun = @(x) r*x;
sigma_fun = @(x) sigma*x;
S_0=100; 
Strike = 90; 
payoff = @(x) max(x-Strike,0);

% True option value by Black-Scholes formula
[Call,Put] = blsprice(S_0, Strike, r, T, sigma);
tic

% Loop over sample sizes in M
for k = 1:M_RMSE
  rng(12345+k);
  for j=1:numel(N)                			     
    E_MC = 2*MonteCarloEuler(T,1,2*N(j),M(j),S_0,mu_fun,sigma_fun,payoff)-MonteCarloEuler(T,1,N(j),M(j),S_0,mu_fun,sigma_fun,payoff);	
    RMSE(k,j) = abs(Call - exp(-r*T)*E_MC).^2;
  end
end
RMSE = sqrt(mean(RMSE,1));
time = toc;

% compute convergence rates
delta=T ./N;
rate_delta = polyfit(log(delta),log(RMSE),1);
disp(['Weak convergence rate of the MonteCarloEuler scheme w . r . t . to step size delta: ', num2str(rate_delta(1))]);
rate_M = polyfit(log(M),log(RMSE),1);
disp(['Weak convergence rate of the MonteCarloEuler scheme w . r . t . to number of samples M: ', num2str(rate_M(1))]);