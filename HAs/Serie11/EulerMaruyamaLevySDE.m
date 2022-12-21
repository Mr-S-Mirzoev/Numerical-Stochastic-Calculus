function Y = EulerMaruyamaLevySDE(T, xi, mu, sigma, eta, W, L)
N = size(W,1) - 1; % number of equally spaced time intervals 
Delta = T/N; % lenght of equally spaced time intervals
K = size (W,2); % number of samples
Y = repmat(xi, 1, K); % initial condition
for i = 1:N
    dW = W(i+1, :)-W(i, :); % increments of the K one-dimensional Brownian motions
    dL = L(i+1, :)-L(i, :); % increments of the K Levy processes
    I = 1:K;
    J = 1:K;
    dW_sparse = sparse(I, J, dW);
    dL_sparse = sparse(I, J, dL);
    Y = Y + mu(Y)*Delta + sigma(Y)*dW_sparse + eta(Y)*dL_sparse; % KEuler realizations of the EulerMaruyama approximation of X at t=i*Delta
end
end

