% Monte Carlo-Euler simulation for the Heston model
clear all 
close all

% Simulation parameters and initialization
M = 2.^(10:2:18);   % number of samples
T  = 1;      % final time
N  = sqrt(T*M);    % number of refinement steps, yields balanced errors since delta^2 = T^2/N^2 = 1/M;
M_RMSE = 10; % number of samples for the RMSE
RMSE = zeros(M_RMSE, length(M)); % empty vector to hold errors

% Heston parameters and SDE coefficients
r = 0.01;
v_0 = .5;   
a = 2;
b = .5;
sigma = .25;

% Truncated Euler Scheme
mu_fun =@(x) [zeros(1,size(x,2)); a*b*ones(1,size(x,2))] + diag([r; -a])*x;
sigma_fun =@(x,M) reshape([sqrt(max(x(2, :),0)) .*x(1,:); zeros(2, M); sigma*sqrt(max(x(2, :),0))], [2, 2*M]);
% Note that sigma also depends on the number of samples M

S_0=100; 
K = 90; 
payoff = @(x) max(x-K,0);

% True option value in Heston model by built-in function
[Call, ~] =  optByHestonFFT(r, S_0, today, datemnth(today,12), 'call', K, v_0, b, a, sigma, 0);
% Call = 31.8991

tic
% Loop over sample sizes in M
for k = 1:M_RMSE
  rng(12345+k);
  for j=1:numel(M)                			     
    E_MC = MonteCarloEuler(T,2,N(j),M(j),[S_0; v_0],mu_fun,@(x)sigma_fun(x,M(j)),payoff);	
    RMSE(k,j) = (Call - exp(-r*T)*E_MC(1)).^2;
  end
end
RMSE = sqrt(mean(RMSE,1));
time=toc;

% compute convergence rates
delta=T./N;
rate_delta = polyfit(log(delta),log(RMSE),1);
disp(['Weak convergence rate of the MonteCarloEuler scheme w . r . t . to step size delta: ', num2str(rate_delta(1))]);
rate_M = polyfit(log(M),log(RMSE),1);
disp(['Weak convergence rate of the MonteCarloEuler scheme w . r . t . to number of samples M: ', num2str(rate_M(1))]);

% plot results
loglog(delta .^-1, [RMSE; exp(rate_delta(1)*log(delta)+rate_delta(2))],'LineWidth',2,'Marker','*')
xlabel('Inverse step size $ {\Delta t}^{-1} = \sqrt M$', 'interpreter', 'latex')
ylabel('Estimated weak error $ {\Delta t}^{-1} = \sqrt M$', 'interpreter', 'latex')
legend({'Estimated error',sprintf('Support line $\\mathcal{O}(deltat^{%0 .3f})$',rate_delta(1))}, 'interpreter', 'latex')
axis tight