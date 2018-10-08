% Smith.m 
n = 11;                             % Max_degree + 1
vec = eye(n,n);                     % Initializing matrix
format shortg
for i=1:n
    for j=1:i-1
        vec(i,:) = vec(i,:) - polydot(vec(j,:),vec(i,:)) * vec(j,:) ;       % For each normalized vector before, deduce the projection on it
    end
    vec(i,:) = vec(i,:) / sqrt( polydot(vec(i,:) , vec(i,:) ) );            % Normalize vector
end
vec(abs(vec)<1e-7) = 0;            % Error tolerance
disp(vec);                         % Show the result

a = zeros(n,n);                    % correlation matrix

for i=1:n
    for j= 1:n
        a(i,j) = polydot(vec(i,:),vec(j,:));
    end
end
a(abs(a)<1e-7) = 0;
disp(a);
