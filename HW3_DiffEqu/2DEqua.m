% This algorithm is similiar to the previous one. It's just presented in a different way:
%
%     (1) ∂∂f/(∂x)^2 |(x,y)=(xi,yj)  = ( f[i-1][j] - 2*f[i][j] + f[i+1][j] ) / h^2
%     (2) ∂∂f/(∂y)^2 |(x,y)=(xi,yj)  = ( f[i][j-1] - 2*f[i][j] + f[i][j+1] ) / h^2
%
%     In total, we get
%       ∂∂f/(∂x)^2 + ∂∂f/(∂y)^2 = (1 1 -2 1 1) * ( f[i-1][j] f[i+1][j]  f[i][j]  f[i][j-1]  f[i][j+1])T = xi^2 + yj^2
%     Notice that for absolute physical address(in matlab): 
%           add(f[i-1][j]) + 1 = add(f[i-1][j]), add(f[i][j-1]) + n = add(f[i][j])

n = 100;                          % Size of Matrix
t = linspace(0,1,n);            % Split interval to calculate
h = (1-0) / (n-1);              % Step for equation

A = sparse(n^2,n^2);            % Create Matrix A
b = zeros(n^2,1);               % Right-hand-side value

for i=1:n
    for j=1:n
        id = sub2ind([n,n],i,j);            % Translate into matrix id
        
        if i==1 || i==n || j==1 || j==n     % For boundary,just apply the boundary condition
            A(id,id) = 1;
            b(id) = 0;
        else
            A(id,[id-1 , id+1]) = [1/h^2 , 1/h^2];  % For grid (i,j)-->(xi,yj),concerning x, Apply the second derivative
            A(id,[id-n , id+n]) = [1/h^2 , 1/h^2];  % For grid (i,j)-->(xi,yj),concerning y, Apply the second derivative
            A(id,id) = -4/h^2;                      % (i,j) is used twice in two direction i.e. 2*(-2/h^2)
            b(id) = t(i)^2+t(j)^2;                  % Use equation ∂∂f/(∂x)^2 + ∂∂f/(∂y)^2 = x^2 + y^2 (xi,yj) <===> (ti,tj)
        end
    end
end

x = A \ b;                  % Solve equation
x = reshape(x,n,n);         % Reshape x           
surf(t,t,x);                % Show 3d graph
A=full(A);                  % Save A as image
A = abs(A) >= 1e-8;
figure
imshow(A)
