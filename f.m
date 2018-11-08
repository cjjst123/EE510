% mapower.m
A = [0 -3 -2;2 5 2;-2 -3 0];                % Matrix A

u = zeros(3,3);                             % Initialize eigenvectors
eigen = zeros(1,3);
epoch = 200;

for i = 1:2                                 % Find the biggest two eigenvecors w.r.t largest eigenvalue
    x = rand(3,1);
    for j = 1:epoch
        for k=1:i-1
            x = x - u(:,k)' * x * u(:,k);   % Gram-Smith method
        end
        x = A*x;                            % Amplify the component
        x = x/norm(x);                      % normalization        
    end
    u(:,i) = x;                             % Normalized eigenvector       
    eigen(i) = x'*A*x;                      % Save the eigenvalue
end

inv_A = inv(A);                             % Use inverse to find smallest eigenvalue
x = rand(3,1);
for j = 1:epoch
    x = inv_A*x;
    x = x / norm(x);
end
u(:,3) = x;
eigen(3) = x'*A*x;  
fprintf('Eigenvectors are :\n')
disp(u);
fprintf('Eigenvalues are: \n')
disp(eigen);
fprintf('Check convergency:\n Au ./ u =\n')
disp(A*u./u)
