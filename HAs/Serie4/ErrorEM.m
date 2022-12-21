clear all
close all
N0 = 10;     % number of steps on coarsest level
L  = 5;      % number of refinement steps
M  = 10^6;   % number of samples
T  = 1;      % final time
xi = 1;      % initial condition

% generate M sample paths of a Brownian motion at the finest grid points
Nmax = N0*2^L; % number of steps on finest level
rng(1234567)
W =[zeros(1,M);sqrt(T/Nmax)*cumsum(randn(Nmax,M))];

% vector to hold differences between approximations
YTdiff = zeros(L-1,1);

% loop over levels
  for l=0:L
    N = N0*2^l;
    part = 1+ 2^(L-l)*(0:N);
    Wpart = W(part, :); % to extract M sample paths of the Brownian motion at the grid points with time step size 1/(N0*2^l)
    YT = EulerMaruyama(T, xi, Wpart); % M realizations of the EulerMaruyama approximation of X at t=T with time step size 1/(N0*2^l)
    if l>0
        YTdiff(l) = sqrt(mean(abs (YT - YT_previous) .^2));
    end
    YT_previous = YT;
    
  end

% compute strong convergence rate
Delta = T ./(N0*2.^(0:L-1)');
r = polyfit(log(Delta),log(YTdiff),1);
disp(['Strong rate of convergence in L^2: ', num2str(r(1))]);