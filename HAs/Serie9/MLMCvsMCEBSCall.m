% Multi Level Monte Carlo and Monte Carlo-Euler simulations for the Black-Scholes model
clear all 
close all

% Simulation parameters and initialization
epsilon=[0.05,0.02,0.01,0.005,0.002]; %tolerance
T  = 1;      % final time
M_RMSE = 10; % number of samples for the RMSE
RMSE_ML = zeros(M_RMSE, length(epsilon)); % empty vector to hold errors for ML
RMSE_MC = zeros(M_RMSE, length(epsilon)); % empty vector to hold errors for standard MC
time_ML = zeros(M_RMSE, length(epsilon)); % empty vector to hold computational times for ML
time_MC = zeros(M_RMSE, length(epsilon)); % empty vector to hold computational times for standard MC
N=zeros(1,length(epsilon));
K=zeros(1,length(epsilon)); 
N=T./epsilon; % number of refinement steps for the standard MC scheme
K=N.^2; % number of samples for the standard MC, yields balanced errors since K=N^2;

% Black-Scholes parameters and SDE coefficients
r = 0.05;
sigma = 0.1;
mu_fun = @(x) r*x;
sigma_fun = @(x) sigma*x;
S_0=100; 
Strike =100; 
payoff = @(x) max(x-Strike,0);
alpha=1;
beta=1;
gamma=1;

% True option value by Black-Scholes formula
[Call,Put] = blsprice(S_0, Strike, r, T, sigma);
% Loop over tolerance epsilon
for k = 1:M_RMSE
  rng(12345+k);
  for j=1:numel(epsilon) 
    tic
    E_ML = MultiLevelMonteCarlo(T,S_0,mu_fun,sigma_fun,epsilon(j),alpha,beta,gamma,payoff);	
    RMSE_ML(k,j) = (Call - exp(-r*T)*E_ML).^2;
    time_ML(k,j)=toc;
    tic
    E_MC = MonteCarloEuler(T,1,N(j),K(j),S_0,mu_fun,sigma_fun,payoff);
    RMSE_MC(k,j) = (Call - exp(-r*T)*E_MC) .^2;
    time_MC(k,j)=toc;
  end
end
RMSE_ML = sqrt(mean(RMSE_ML,1));
time_ML= mean(time_ML,1);
RMSE_MC = sqrt(mean(RMSE_MC,1));
time_MC= mean(time_MC,1);

% compute convergence rates
rate_epsilon_ML = polyfit(log(epsilon),log(RMSE_ML),1);
disp(['Convergence rate of the Multi Level Monte Carlo scheme w . r . t . to epsilon:  ', num2str(rate_epsilon_ML(1))]);
% compute convergence rates
cost_epsilon_ML = polyfit(log(epsilon),log(time_ML),1);
disp(['Overall complexity of the Multi Level Monte Carlo method w . r . t . to epsilon:', num2str(cost_epsilon_ML(1))]);
% compute convergence rates
rate_epsilon_MC = polyfit(log(epsilon),log(RMSE_MC),1);
disp(['Convergence rate of the Monte Carlo Euler scheme w . r . t . to epsilon:', num2str(rate_epsilon_MC(1))]);
% compute convergence rates
cost_epsilon_MC = polyfit(log(epsilon),log(time_MC),1);
disp(['Overall complexity of the Monte Carlo Euler method w . r . t . to epsilon: ', num2str(cost_epsilon_MC(1))]);

% plot results
loglog(epsilon, [time_ML;time_MC],'LineWidth',2,'Marker','*')
xlabel('tollerance $\epsilon$', 'interpreter', 'latex')
ylabel('time', 'interpreter', 'latex')
axis tight