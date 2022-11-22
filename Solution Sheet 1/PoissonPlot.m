function PoissonPlot()
  rng('default');
  N=10^5;
  lambda=10;
  X=Poisson(N,lambda);
  histogram(X,10^2, 'Normalization', 'pdf')
  xlabel('Realized values')
  legend('Sampled values')
  xlim([0 50])
end