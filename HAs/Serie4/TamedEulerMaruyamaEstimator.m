clear all 
close all
N =  10^3;   % number of steps
M  = 10^5;   % number of samples 
T  = 3;      % final time
xi = 1;      % initial condition  
rng(1234567)

% M sample paths of the Brownian motion at the grid points with time step size N
W =[zeros(1,M);sqrt(T/N)*cumsum(randn(N,M))];

Y_mean=zeros(1,1);
YT = TamedEulerMaruyamaGL(T, xi, W); % M realizations of the EulerMaruyama approximation of X at T
Y_mean = mean(abs(YT).^2) % Monte Carlo approximation based on M samples