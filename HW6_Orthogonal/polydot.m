%  polydot.m
function [res] = polydot(x,y)   % Input two matrix (i.e. 1,2x,3x^2... as [1 2 3]) as argu 
    
    mul = conv(x,y);            % Polydot is equavalent to discrete convolution
    n = size(mul,2);            % Get the size of product
    
    intcof = 1./(1:n);          
    res = intcof*mul';          % Directly take matrix multiplication as integral( [1 2 3] * [1 1/2 1/3]')
end

