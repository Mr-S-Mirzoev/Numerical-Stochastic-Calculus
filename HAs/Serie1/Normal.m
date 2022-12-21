% Function to sample general two-dimensional normally distributed random variables
function x=Normal(v1, v2, c11, c12, c22)
    v = [v1; v2]; 
    Q = [c11 c12; c12 c22]; 
% Generate two-dimensional standard normal random variables using the Matlab function
% randn()
x=randn(2,1);
% Transform to general two-dimensional standard normal random variables
  A = chol (Q)'; 
  x = v + A*x;
end