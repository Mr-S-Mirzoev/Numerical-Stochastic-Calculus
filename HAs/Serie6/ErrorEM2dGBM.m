clear all 
close all
N0 = 10;   % number of steps on coarsest level
L  = 4;    % number of refinement steps
M  = 10^5; % number of samples 
T  = 1;      % final time
xi = [1; 2]; % initial condition 
% coefficients of the SDE
mu = [.5; 2];
mu_fun = @(x) diag(mu)*x;
sigma = [1 0; 0 2];
sigma_fun = @(x) sigma*reshape([x(1,:); zeros(2, M); x(2, :)], [2, 2*M]);

% generate M sample paths of a Brownian motion at the finest grid points
Nmax = N0*2^L; % number of steps on finest level
rng(123456)
% first entries of the M sample paths at the finest grid points
W1 =[zeros(1,M);sqrt(T/Nmax)*cumsum(randn(Nmax,M))];
% second entries of the M sample paths at the finest grid points
W2 =[zeros(1,M);sqrt(T/Nmax)*cumsum(randn(Nmax,M))];
W = [W1 W2];

YTerr = zeros(L+1,1); % error vector
% exact solution 
Ysol1 = exp(W1(end,:))*xi(1);
Ysol2 = exp(2*W2(end,:))*xi(2);
Ysol = [Ysol1; Ysol2];

% loop over levels
  for l=0:L                			     
    N = N0*2^l;	
    part = 1+ 2^(L-l)*(0:N);
    Wpart = W(part, :); % to extract M sample paths of the Brownian motion at the grid points with time step size 1/(N0*2^l)
    YT = EMMultiDim(T, 2, xi, mu_fun, sigma_fun, Wpart); % M realizations of the EulerMaruyama approximation of X at t=T with time step size 1/(N0*2^l)
    YT_error = YT - Ysol;
    YTerr(l+1) = mean(vecnorm(YT_error));
  end             

% compute convergence rate
Delta = T ./(N0*2.^(0:L)');
r = polyfit(log(Delta),log(YTerr),1);
disp(['Strong rate of convergence in L^1: ', num2str(r(1))]);
