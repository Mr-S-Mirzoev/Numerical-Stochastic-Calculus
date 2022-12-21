clear all
close all

rng(123456)

N0 = 10;   % number of steps on coarsest level
L  = 3;    % number of refinement steps
M  = 10^7; % number of samples
T  = 1;    % final time
xi = ones(1, M); % initial condition
p = 2; f = @(x)x.^p; % test function
mu0 = 0.5; 
sigma0 = 1;

% generate M sample paths of a Brownian motion at the finest grid points
Nmax = N0*2^(L);  % number of steps on finest level
W =[zeros(1,M);sqrt(T/Nmax)*cumsum(randn(Nmax,M))];

% vector to hold approximated mean values
YMean = zeros(L+1,1);

tic
% loop over levels
  for l=0:L
    N = N0*2^l;
    part1 = 1+ 2^(L-l)*(0:N);
    Wpart1 = W(part1, :); % to extract M sample paths of the Brownian motion at the grid points with time step size 1/(N0*2^l)
    N2=N0*2^(l-1);
    part2= 1+ 2^(L-l+1)*(0:N2);
    Wpart2 = W(part2, :); % to extract M sample paths of the Brownian motion at the grid points with time step size 1/(2*N0*2^l)
    YT1 = EulerMaruyama(T,xi,Wpart1); % M realizations of the EulerMaruyama approximation of X at t=T with time step size 1/(N0*2^l)
    YT2 = EulerMaruyama(T,xi,Wpart2); % M realizations of the EulerMaruyama approximation of X at t=T with time step size 1/(2*N0*2^l)
    YMean(l+1) = mean(2*f(YT1)-f(YT2));
  end
time=toc;

% compute convergence rates ...
true_mean = exp(p*mu0*T+sigma0^2/2*T*(p^2-p)); %Exact mean value

MeanDiff = abs(YMean-true_mean);

% compute weak convergence rate
Delta = T ./(N0*2.^(0:L)');
r = polyfit(log(Delta),log(MeanDiff),1);
disp(['Weak rate of convergence: ', num2str(r(1))]);