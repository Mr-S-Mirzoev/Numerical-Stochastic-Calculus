% Monte Carlo-Euler scheme to approximate E(f(X_T)) where the
% SDE X_t = mu(X_t)dt + sigma(X_t)dW_t
%     X_ 0 = xi; t in [0,T] is solved 
% using the Euler-Maruyama method

function E_MC = MonteCarloEuler(T,m,N,M,xi,mu,sigma,f)

% step size of Euler scheme
delta=T./N;

% Sample M paths of a m-dimensional Brownian motion at the discrete values
% t=i*delta with i=0,1,...,N .
W=[];
for j = 1:m
    Wj = [zeros(1,M);sqrt(delta)*cumsum(randn(N,M))];
    W = [W Wj];
end

% Call Euler-Maruyama scheme 
Y = EMMultiDim(T, m, xi, mu, sigma, W);

% Monte Carlo estimation of expected value
E_MC = mean(f(Y),2);

end