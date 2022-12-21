% Matlab function to plot paths of variance Gamma Levy processes
function VarianceGamma(T,N,alpha,beta,gamma1,gamma2,sigma)
dt=T/N; %step size
t = 0:dt:1; %vector time steps
rng(1234)
GS = zeros(1, numel(t)); %inizialize Gamma subordinator 
Z = randn(size(GS));

GS = gamrnd(dt*alpha, 1/beta, size(GS)); %Gamma subordinator increments

VG = gamma1*dt+gamma2*GS + sigma.*sqrt(GS).*Z; %subordinated Brownian motion increments
GS = cumsum(GS, 2); %Gamma subordinator at time steps t = 0:dt:1
VG = cumsum(VG, 2); %subordinated Brownian motion at time steps t = 0:dt:1
close all

%Font Size in plots
axfont=16;
titlefont=18;
legendfont=16;
figure_pos=[10 5 20 15];

%Plotting the results
figure('Units', 'centimeters', 'Position', figure_pos);
plot(t, GS, 'LineWidth' , 2)
xlabel('$t$', 'Interpreter', 'latex','FontSize',axfont)
ylabel('$GS(t)$', 'Interpreter', 'latex','FontSize',axfont)
grid on
axis tight

figure('Units', 'centimeters', 'Position', figure_pos);
plot(t, VG, 'b', 'LineWidth' , 2)
xlabel('$t$', 'Interpreter', 'latex','FontSize',axfont)
ylabel('$VG(t)$', 'Interpreter', 'latex','FontSize',axfont)
grid on
axis tight
end