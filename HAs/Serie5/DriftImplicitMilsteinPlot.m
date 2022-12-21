% SDE parameters for the CIR process
T = 1;
N = 10^3;
v0=0.5;
a=2;
b=0.5;
sigmav=0.25;

%fix random seed
rng(123456)

%Call of drift-implicit Milstein scheme and plot of one approximated path
plot( (0:T/N:T), DriftImplicitMilstein(T,N,v0,a,b,sigmav))