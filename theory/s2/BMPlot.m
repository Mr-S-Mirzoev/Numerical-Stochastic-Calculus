%Script to plot (approximate) paths of Brownian motions
close all
%Initializing simulation parameters and empty matrices
T=1; t = 0:2^-10:T; N = [2^7 2^8 2^9];
WInt = zeros(numel(N),numel(t)); 
W = zeros(numel(N),numel(t));

%For loop over different value of N
for i = 1:length(N)
    %Incremental simulation with linear interpolation
    WInt(i,:) = BMIncInterp(t, T, N(i));
    %Exact simulation over Brownian bridge
    W(i,:) = BMBridgeInterp(t, T, N(i));
end

%Visualizing
figure
plot(t, WInt, 'LineWIdth', 1.5)
axis tight
xlabel('$t$','Interpreter','latex')
ylabel('$\widetilde{W}$','Interpreter','latex')
legend({[repmat(['$N = $'],numel(N),1), num2str(N')]},'Interpreter','latex')
title('Approximate paths of a Brownian motion','Interpreter','latex')

%Visualizing
figure
plot(t, W, 'LineWIdth', 1.5)
axis tight
xlabel('$t$','Interpreter','latex')
ylabel('$W$','Interpreter','latex')
legend({[repmat(['$N = $'],numel(N),1), num2str(N')]},'Interpreter','latex')
title('Exact paths of a Brownian motion','Interpreter','latex')
