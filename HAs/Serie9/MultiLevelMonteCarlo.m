function E_ML = MultiLevelMonteCarlo(T,xi,mu,sigma,epsilon,alpha,beta,gamma,f)
L=ceil(-log2(epsilon)); 
N0=2*T;
N=zeros(1,L);
for l=1:L
N(l)=N0*2^l; %number of time steps at refinement level l
end
delta=T./N;
sum=0;
if beta==gamma
   sum=L;
else
    for i=0:L
        sum=sum+2^((gamma-beta)*l/2);
    end
end
K=zeros(1,L);
for l=1:L
K(l)=sum*2^(2*alpha*L)*2^(-(beta+gamma)*l/2); %number of Monte Carlo samples at refinement level l
%K(l)=L*2^(2*L-l);
end
%Level l=1:
% Sample K(1) paths of a one-dimensional Brownian motion at the discrete values
% t=i*delta(1) with i=0,...,N(1)
W=[];
W = [zeros(1,K(1));sqrt(delta(1))*cumsum(randn(N(1),K(1)))];
% Call Euler-Maruyama scheme 
Y = EMMultiDim(T, 1, xi, mu, sigma, W);
% Monte Carlo estimation of expected value
E_ML = mean(f(Y),2);
%Levels l>2:
for l=2:L
    dW1=sqrt(delta(l))*randn(N(l),K(l)); 
    dW2=dW1(1:2:end,:)+dW1(2:2:end,:);
    W1=[zeros(1,K(l));cumsum(dW1,1)]; % Sample K(l) paths of a one-dimensional Brownian motion at the discrete values t=i*delta(l) with i=0,...,N(l)
    W2=[zeros(1,K(l));cumsum(dW2,1)]; % Sample K(l) paths of a one-dimensional Brownian motion at the discrete values t=i*delta(l-1) with i=0,...,N(l-1)
    Z1=EMMultiDim(T, 1, xi, mu, sigma, W1); % Call Euler-Maruyama scheme
    Z2=EMMultiDim(T, 1, xi, mu, sigma, W2);
    E_MC=mean(f(Z1)-f(Z2),2); % Monte Carlo estimation of expected difference
    E_ML=E_ML+E_MC; % Multi Level Monte Carlo estimation of expected value
end
end