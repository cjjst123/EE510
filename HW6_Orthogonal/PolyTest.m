% PolyTest.m
pol = cell(1,4);                    % Create pointer container for matrix
pol{1} = [1];                       % Initializing four polynomials as matrices 
pol{2} = sqrt(3)*[-1 2];
pol{3} = sqrt(5)*[1 -6 6];
pol{4} = sqrt(7)*[-1 12 -30 20];

a = zeros(4,4);                     % Correlation matrix, where a_{ij} means the inner product of pol_i and pol_j 

for i=1:4
    for j= 1:4
        a(i,j) = polydot(pol{i},pol{j});
    end
end
a(abs(a)<1e-8) = 0;                 % Error tolerance. This elimiates results such as -0.00
disp(a);
