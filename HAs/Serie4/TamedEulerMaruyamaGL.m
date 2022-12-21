function Y = TamedEulerMaruyamaGL(T, xi, W)
N = size(W,1) - 1; % number of equally spaced time intervals 
Delta = T/N; % lenght of equally spaced time intervals
M = size (W,2); % number of samples
sigma=7; 
mu_fun=@(x)(1/2*sigma^2*x-x.^3); % coefficients of the SDE
sigma_fun=@(x)sigma*x;
Y = repmat(xi, 1, M); % initial condition
Z = zeros(1, M); 
for i = 1:N
    dW = W(i+1, :)-W(i, :); % increments of the M one-dimensional Brownian motions
    I = 1:M;
    J = 1:M;
    dW_sparse = sparse(I, J, dW);
    Z = mu_fun(Y)*Delta + sigma_fun(Y)*dW_sparse; % M realizations of the EulerMaruyama approximation of X at t=i*Delta
    Y=Y+Z./max(1,Delta*abs(Z)); % M realizations of the increment-tamed EulerMaruyama approximation of X at t=i*Delta
end
end