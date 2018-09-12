%   This question is about discreting the interval and apply numerical analysis to solve equation for certain points.
%
%   Here are two critical pinciples:
%   (1)  f'[n]= (f[n+1] - f[n-1]) / (2*h)
%   (2)  f"[n]= (f[n+1] - 2*f[n] + f[n-1]) / h^2
%
%   By applying numerical analysis, we can easily create function. For f"(x) - 2*f'(x) = cosx,
%   let x = xn, The equation can be written as:
%
%          (1/h^2+1/h , 1/h^2 ,1/h^2-1/h) * (x[n-1],x[n],x[n+1])T = cos(xn)
%
%    Then we can create sparse matrix.

n = 2000;           % Sampling numbeer
l = 0;              % Left boundary
r = pi;             % Right boundary
vl = 0;             % f(l)
vr = 0;             % f(r), This can also be -1
h =(r-l)/(n-1);     % Step for equation

A = sparse(n,n);        % Target matrix
b = zeros(n,1);         % Right-hand-side value
x = linspace(l,r,n);    % Split interval to calculate 

b([1 n]) = [vl vr];     % For left and right, assigning initial value
b(2:n-1) = cos(x(2:n-1));       % Create differential equation

A(1,1) = 1;                     % For both-side, assigning cof 1
A(n,n) = 1;

for i=2:n-1
    A(i,i-1:i+1) = [1/h^2+1/h , -2/h^2 , 1/h^2-1/h];          %Differential equation
end

fx = A \ b;
plot(x,fx);
