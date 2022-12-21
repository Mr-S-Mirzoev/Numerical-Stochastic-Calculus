clear all
close all

rng(1234567)

N0 = 10;    % number of steps on coarsest level
L  = 4;    % number of refinement steps
M  = 10^6;    % number of samples
T  = 1;    % final time
xi = ones(1, M);    % initial condition
c = 5; 
f = @(x)x>c;     % test function

%handles for Milstein scheme
mu0 = 0.5; sigma0 = 1;
mu = @(x) mu0*x; 
sigma = @(x) sigma0*x;
sigma_prime = @(x) sigma0*ones(size(x));


% generate M sample paths of a Brownian motion at the finest grid points
Nmax = N0*2^L;  % number of steps on finest level
W =[zeros(1,M);sqrt(T/Nmax)*cumsum(randn(Nmax,M))];

% vector to hold approximated mean values
YMean = zeros(L+1,1);

% loop over levels
  for l=0:L
    N = N0*2^l;
    part = 1+ 2^(L-l)*(0:N);
    Wpart = W(part, :); % to extract M sample paths of the Brownian motion at the grid points with time step size 1/(N0*2^l)
    YT = EulerMaruyama(T, xi, Wpart); % M realizations of the EulerMaruyama approximation of X at t=T with time step size 1/(N0*2^l)
    YMean(l+1) = mean(f(YT));
  end

% compute convergence rates ...
% true_mean = exp(p*mu0*T+sigma0^2/2*T*(p^2-p)); %Exact mean value
true_mean = 1-normcdf( 1/(sqrt(T)*sigma0)*(log(c)-(mu0-sigma0^2/2)*T) );
MeanDiff = abs(YMean-true_mean);

% compute weak convergence rate
Delta = T ./(N0*2.^(0:L)');
r = polyfit(log(Delta),log(MeanDiff),1);
disp(['Weak rate of convergence: ', num2str(r(1))]);