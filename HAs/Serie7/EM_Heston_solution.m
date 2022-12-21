% Solve SDE for Heston model
% using Euler-Maruyama with N0,2*N0,...,2^L*N0 time steps
% Strong rates are computed using 
% an overkill solution with 2^(L+extra)*N0 time steps
clear all 
close all
N0 = 10;    % number of steps on coarsest level
L  = 4;     % number of refinement steps
extra = 2;  % extra levels of refinement for overkill solution
M  = 10^5;  % number of samples 
T  = 1;     % final time
s0 = 10;    % initial condition for S_t
v0 = .5;    % initial value for volatility v_t
x0 = [s0; v0;];  
r = .05;
a = 2;
b = .5;
sigma = .25;
mu_fun =@(x) [zeros(1,size(x,2)); a*b*ones(1,size(x,2))] + diag([r; -a])*x;
% Truncated Euler scheme, volatility is cut off at zero
sigma_fun =@(x) reshape([sqrt(max(x(2, :),0)) .*x(1,:); zeros(2, M); sigma*sqrt(max(x(2, :),0))], [2, 2*M]);

L_ok = L + extra;
N_ok = N0*2^L_ok; 
rng(12345)
% path of Brownian motion 1 on finest level
W1 = [zeros(1,M);sqrt(T/N_ok)*cumsum(randn(N_ok,M))];
% path of Brownian motion 2 on finest level
W2 = [zeros(1,M);sqrt(T/N_ok)*cumsum(randn(N_ok,M))]; 
W  = [W1 W2];
    
% values of S_T with time step T/(N*2^l), l=0,...,L,L_ok
ST = zeros(L+2,M);         
% loop over levels
Lv = [0:L,L_ok]; 
for l=1:L+2 % l=0,...,L,Le			
    le=Lv(l); 
    N = N0*2^le;
    part = 1+ 2^(L_ok-le)*(0:N); 
    Wpart = W(part, :);
    XT = EMMultiDim(T, 2, x0, mu_fun, sigma_fun, Wpart);
    ST(l,:) = XT(1,:); % E-M values for S_T
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% errors for ST compared to overkill solution
STerr = ST(1:L+1,:)-repmat(ST(L+2,:),L+1,1);
% mean errors for strong L^1 convergence
STerr1 = mean(abs(STerr),2); 
% mean square errors for strong L^2 convergence
STerr2 = sqrt(mean(STerr .^2,2)) ;         

% vector of time step sizes
hv = T ./(N0*2.^(0:L)'); 

% compute convergence rates
r1 = polyfit(log(hv),log(STerr1),1);
disp(['Strong rate of convergence in L^1: ', num2str(r1(1))]);

r2 = polyfit(log(hv),log(STerr2),1);
disp(['Strong rate of convergence in L^2: ', num2str(r2(1))]); 

figure(1) 
loglog(hv,STerr1,'-x',hv,STerr2,'-o',...
    hv,exp(r1(2))*sqrt(hv),'--',...
    hv,exp(r2(2))*sqrt(hv),'--');
set(groot,'defaultLegendInterpreter','latex');
legend('$L^1$-error', '$L^2$-error', '$O(h^{1/2})$', '$O(h^{1/2})$','Location', 'SouthEast'); 
grid on
xlabel('time step size h')
ylabel('strong error')
title('Euler-Maruyama method: strong error')
set(gca,'fontsize',16)