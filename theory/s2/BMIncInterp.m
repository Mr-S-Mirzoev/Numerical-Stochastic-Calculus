% Function that returns the linear interpolation WInt of the values
% W_{t_ 0},W_{t_ 1},...,W_{T} with t_i = i*T/N at the vector t
function WInt = BMIncInterp(t,T,N)

% Simulation of values at discrete time grid
DeltaT = T/N;
rng(12345)
BM = cumsum([0,randn(1,N)])*sqrt(DeltaT);

% Linear interpolation
t_i = 0:DeltaT:T;
WInt = interp1(t_i, BM, t);

end
