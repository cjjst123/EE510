% star.m
data = csvread('Cepheid.csv');                  % Read csv
period = log10(data(:,1));                      % Take log10 of the period
maxi = data(:,2);
mini = data(:,3);

A_max = [period,ones(size(period))];            % Max regression matrix
A_min = [period,ones(size(period))];            % Min regression matrix

X_max = pinv(A_max) * maxi;                     % Cof of max
X_min = pinv(A_min) * mini;                     % Cof of min

plot(period,mini,'-ro',period,maxi,'-ro',period,A_min * X_min,'-b',period,A_max * X_max,'-b')

xlabel('period(log)')
ylabel('Lumisity')

axis ij;                                        % Reverse y axis
u_max = mean(maxi);
u_min = mean(mini);

R_max_2 = 1 - sum( (maxi -  A_max * X_max).^2 ) / sum( (maxi-u_max).^2 );       % Calculate R_max ^2
R_min_2 = 1 - sum( (mini -  A_min * X_min).^2 ) / sum( (mini-u_min).^2 );       % Calculate R_min ^2

fprintf('Rmax^2 = %f \nRmin^2 = %f\n',R_max_2,R_min_2)
