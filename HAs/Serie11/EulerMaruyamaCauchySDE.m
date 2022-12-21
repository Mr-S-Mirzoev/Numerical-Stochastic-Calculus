clear all 
close all
N0 = 10;   % number of steps on coarsest level
L  = 4;    % number of refinement steps
extra = 4;  % extra levels of refinement for overkill solution
Lmax = L + extra;
Nmax = N0*2^Lmax;  % number of steps on finest level
K  = 10^4; % number of samples 
T  = 1;      % final time
xi = 1; % initial condition 

% coefficients of the SDE
mu = 0.5;
mu_fun = @(x) mu*x;
sigma = 1;
sigma_fun = @(x) sigma*x;
eta=0.5;
eta_fun = @(x) eta*x;

% coefficients of the Cauchy subordinator
mu = 0;
lambda = 1; 


% generate K sample paths of a Brownian motion at the finest grid points
rng(1234)
W =[zeros(1,K);sqrt(T/Nmax)*cumsum(randn(Nmax,K))];

% generate K sample paths of a Cauchy process at the finest grid points
% (Cauchy distribution is a special case of the "stable distribution")
CS =[zeros(1,K);cumsum(random('stable',1,0,(T/Nmax)*lambda,0,Nmax,K))];

% values of X_T with time step T/(N*2^l), l=0,...,L,Lmax
YT = zeros(L+2,K);         
% loop over levels
Lv = [0:L,Lmax]; 
for l=1:L+2			
    le=Lv(l); 
    N = N0*2^le;
    part = 1+ 2^(Lmax-le)*(0:N); 
    Wpart = W(part, :); % to extract K sample paths of the Brownian motion at the grid points with time step size 1/(N0*2^le)
    CSpart = CS(part, :); % to extract K sample paths of the Cauchy subordinator at the grid points with time step size 1/(N0*2^le)
    YT(l,:) = EulerMaruyamaLevySDE(T, xi, mu_fun, sigma_fun, eta_fun, Wpart, CSpart); % K realizations of the EulerMaruyama approximation of X at t=T with time step size 1/(N0*2^le)
end

% errors for ST compared to overkill solution
YTerr = YT(1:L+1,:)-repmat(YT(L+2,:),L+1,1);
% mean square errors for strong L^2 convergence
YTerr1 = sqrt(mean(YTerr.^2,2));         

% compute convergence rate
Delta = T ./(N0*2.^(0:L)');
r = polyfit(log(Delta),log(YTerr1),1);
disp(['Strong rate of convergence in L^2: ', num2str(r(1))]);