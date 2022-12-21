function Y = Milstein1D(T, xi, mu, sigma, sigma_prime, W)
% 1D SDE X_t = mu(X_t)dt + sigma(X_t)dW_t
% X_ 0 = xi; t in [0,T] is solved
% using the Milstein method
%
N = size(W,1) - 1; % number of equally spaced time intervals
Delta = T/N; % lenght of equally spaced time intervals
M = size(W,2); % number of samples
% Y = repmat(xi, 1, M); % initial condition\
Y = xi;
for i = 1:N
    dW = W(i+1, :)-W(i, :);
    Y = Y + mu(Y)*Delta + sigma (Y) .*dW + 0.5*sigma (Y) .*sigma_prime (Y) .*(dW.^2-Delta);
end
end
