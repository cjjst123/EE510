%okuns.m
GDP = csvread('GDP_change.csv');
UNEM = csvread('Annual_unemployment_rates.csv');

GDP = GDP( GDP(:,1) >=UNEM(1,1) &  GDP(:,1) <=UNEM(end,1) ,:);              % Match input size
assert(size(GDP,1) == size(UNEM,1) );                                       % Argument checking

year_st = GDP(2,1);                         % Year of start and end
year_ed = GDP(end,1);

A = UNEM(2:end,2) - UNEM(1:end-1,2);        % Calculate the difference of unemployment
A = [A ones(size(A)) ];                     % Create LS matrix
b = GDP(2:end,2) - GDP(1:end-1,2);          % Calculate difference of of GDP

x = pinv(A) * b;                            % Acquire regression coefficiency

fprintf('c = %f\nb = %f\n',-x(1),x(2));

[nop,id] = sort(A(:,1));                    % Sort pair (A,b) for line chart display
A=A(id,:);
b=b(id);

plot(A(:,1),b,'ro',A(:,1),A*x,'-b');

