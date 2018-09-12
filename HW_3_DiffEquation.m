%   This question is about discreting the interval and apply numerical analysis to solve equation for certain points.
%
%
%   Here are two critical pinciples:
%   (1)  f'[xn] = (f[xn+1] + f[xn-1]) / h
%   (2)  f"[n]= (f[x_{n+1}] - 2*f[x_{n}] + f[x_{n-1}]) / h^2}
%
%   By applying 

n = 2000;           %Number of dots
l = 0;              %Left boundary
r = pi;             %Right boundary
vl = 0;             %f(l)
vr = -1;            %f(r)
h =(r-l)/(n-1);     %Step for equation

A = sparse(n,n);        %Target matrix
b = zeros(n,1);         %Right-hand-side value
x = linspace(l,r,n);    %Split interval to calculate 

b([1 n]) = [vl vr];     %For left and right, assigning initial value
b(2:n-1) = cos(x(2:n-1));       %Create differential equation

A(1,1) = 1;                     %For both-side, assigning cof 1
A(n,n) = 1;

for i=2:n-1
    A(i,i-1:i+1) = [1/h^2+1/h , -2/h^2 1/h^2-1/h];          %Differential equation
end

fx = A \ b;
plot(x,fx);
