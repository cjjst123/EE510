%PCA.m
a = load('data.mat');       % Load the structure
a = a.data;                 % Obtain the data key

[u,s,v] = svd(a);           % Do SVD
code = v(:,1:2);            % mapping code equals the first two column of v

best = a*code;              % PCA compress

scatter(best(:,1),best(:,2))    % Plot the image
