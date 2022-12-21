%Drift-implicit Milstein scheme for the CIR process
function Y = DriftImplicitMilstein(T,N,v0,a,b,sigmav)
%Initializing vectors and time step
Y = zeros(1,N+1);
Y(1) = v0;
Delta = T/N;
%Drift-implicit scheme (closed-form solution since drift is a linear
%function)
for n = 1:N
Y(n+1) = (1/(1+a*Delta))*(Y(n) + (a*b-sigmav^2/4)*Delta + sigmav*sqrt(Y(n))*sqrt(Delta)*randn+(sigmav^2/4)*(sqrt(Delta)*randn)^2); 
end
end