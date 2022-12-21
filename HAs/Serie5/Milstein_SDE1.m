% Solve the SDE _t = mu(X_t)dt + sigma(X_t)dW_t, X=x0
% using the Milstein method
% Strong rates are computed using
% an overkill solution with 2^(L+extra)*N0 time steps
clear all
close all
N0 = 10;    % number of steps on coarsest level
L  = 4;     % number of refinement steps
extra = 3;  % extra levels of refinement for overkill solution
M  = 10^5;  % number of samples
T  = 1;     % final time
xi = 1;     % initial value of the SDE
mu = @(x) x; %function handle for drift
sigma = @(x) log(1+x.^2); %function handle for diffusion
sigma_prime = @(x) 2*x./(1+x.^2); %function handle for deriviative of diffusion

L_ok = L + extra;
N_ok = N0*2^L_ok;
rng(12345)

% path of Brownian motion on finest level
W = [zeros(1,M);sqrt(T/N_ok)*cumsum(randn(N_ok,M))];

% values of S_T for h=T/(N*2^l), l=0,...,L,L_ok
ST = zeros(L+2,M);
%loop over levels
Lv = [0:L,L_ok];
for l=1:L+2 % l=0,...,L,Le
    le=Lv(l);
    N = N0*2^le;
    part = 1+ 2^(L_ok-le)*(0:N);
    Wpart = W(part, :);
    XT = Milstein1D(T, xi, mu, sigma, sigma_prime, Wpart);
    ST(l,:) = XT;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (ii) strong L^p convergence %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% errors for ST compared to overkill solution
STerr = ST(1:L+1,:)-repmat(ST(L+2,:),L+1,1);
% mean errors for strong L^1 convergence
STerr1 = mean(abs(STerr),2);
% mean square errors for strong L^2 convergence
STerr2 = sqrt(mean(STerr.^2,2)) ;

% vector of time step sizes
hv = T./(N0*2.^(0:L)');

% compute convergence rates
r1 = polyfit(log(hv),log(STerr1),1);
disp(['Strong rate of convergence in L^1: ', num2str(r1(1))]);

r2 = polyfit(log(hv),log(STerr2),1);
disp(['Strong rate of convergence in L^2: ', num2str(r2(1))]);

figure(1)
loglog(hv,STerr1,'-x',hv,STerr2,'-o',...
    hv,exp(r1(2))*hv,'--',...
    hv,exp(r2(2))*hv,'--');
set(groot,'defaultLegendInterpreter','latex');
legend('$L^1$-error', '$L^2$-error', '$O(\Delta t^{1})$', '$O(\Delta t^{1})$','Location', 'SouthEast');
grid on
xlabel('time step size \Delta t')
ylabel('strong error')
title('Milstein method: strong error')
set(gca,'fontsize',16)
