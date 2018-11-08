% decom.m
n = 100;
A = rand(n,n);
A = diag(diag(A)) + triu(A,1) + triu(A,1)';

u = zeros(n,n);                                 % Eigenvectors matrix
eigen = zeros(1,n);

epoch = 300;
isconver = 1;
for i = 1:3
    x = rand(n,1);                              % Randomly generate a vector
    for j = 1:epoch
        for k=1:i-1
            x = x - u(:,k)' * x * u(:,k);       % Gram-Smith normalization
        end
        x = A \ x;                                % Amplify the vector
        x = x/norm(x);                          % Normalization
    end
    u(:,i) = x;                             % Save normalized vector
    eigen(i) = x'*A*x;                      % Save the eigen vector
    
    try
        assert(sum(A*x - eigen(i)* x) < 1e-3)
    catch
        fprintf('Iteration is not convergent\n');
        isconver = 0;
        break
    end
end
if(isconver)
    fprintf('The second  smallest-magnitude eigenvalue is %.6f\n',eigen(2))
    disp(u(:,2)');
    fprintf('\nThe third  smallest-magnitude eigenvalue is %.6f\n',eigen(3))
    disp(u(:,3)');
end
