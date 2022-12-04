function W = BMBridgeInterp(t,T,N)

% Simulation of values at discrete time grid
DeltaT = T/N;

% Brownian bridge simulation
mean = BMIncInterp(t,T,N); % mean values corresponds to linear interpolation
% Calculating variances
sigma_squared = (t - floor(t/DeltaT)*DeltaT) .*(ceil(t/DeltaT)*DeltaT-t)/DeltaT;

W = mean + sqrt (sigma_squared) .*randn(1,numel(t));

end
