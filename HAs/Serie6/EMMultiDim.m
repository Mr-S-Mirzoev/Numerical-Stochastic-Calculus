function Y = EMMultiDim(T, m, xi, mu, sigma, W)
N = size(W,1) - 1; % number of equally spaced time intervals 
Delta = T/N; % lenght of equally spaced time intervals
M = size (W,2)/m; % number of samples
Y = repmat(xi, 1, M); % initial condition
for i = 1:N
    dW = W(i+1, :)-W(i, :); % increments of the M m-dimensional Brownian motions W
    dW1 = reshape (dW, [M, m])';
    dWnew = dW1(:);
    I = repmat(1:M, m, 1);
    I = I(:);
    J = 1:M*m;
    dW_sparse = (sparse(I, J, dWnew))'; % to reorder the Brownian motions increments in a suitable sparse matrix
    Y = Y + mu(Y)*Delta + sigma(Y)*dW_sparse; % M realizations of the EulerMaruyama approximation of X at t=i*Delta
end
end
