function[E_N, V_N, I_CLT, I_Cb] = MCEstimatorCI(h, N, alpha)
    % Sample random points and estimate sample mean and variance
    U =rand(1,N);
    X= h(U);
    E_N = mean(X);
    V_N = N/(N-1)*(mean(X . ^2)-E_N^2);
    
    % Confidence interval based on Chebychev inequality
    I_Cb = [E_N-sqrt(V_N/(N*(1-alpha))); E_N+sqrt(V_N/(N*(1-alpha)))];
    
    % Confidence interval based on CLT
    beta = norminv((1+alpha)/2); 
    I_CLT = [E_N-beta*sqrt(V_N/N); E_N+beta*sqrt(V_N/N)];
end
