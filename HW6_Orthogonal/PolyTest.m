% PolyTest.m
pol = cell(1,4);
pol{1} = [1];
pol{2} = sqrt(3)*[-1 2];
pol{3} = sqrt(5)*[1 -6 6];
pol{4} = sqrt(7)*[-1 12 -30 20];

a = zeros(4,4);

for i=1:4
    for j= 1:4
        a(i,j) = polydot(pol{i},pol{j});
    end
end
a(abs(a)<1e-8) = 0;
disp(a);
