% min_eig
n = 100;
A = rand(n,n);
A = diag(diag(A)) + triu(A,1) + triu(A,1)';
inv_A = inv(A);

x = rand(n,1);                      % Randomly generate a vector x
epoch = 300;                        % Epoch of iteration

for i = 1:epoch                     % Power iteration
    x = inv_A * x;
    x = x / norm(x);
end

eigenval = 1 / (x'*inv_A*x);                  % Calculate eigenvalue(if truely convergent)

try
    assert(sum(A*x - eigenval*x) < 1e-10)   % Check if AX = λx by summing the difference
    fprintf('Check sucess!\n')
    fprintf('The least-magnitude eigenvalue is %.6f.\n',eigenval);
catch
    fprintf('The iteration is not convergent\n')
end

