function [res] = polydot(x,y)
    
    mul = conv(x,y);
    n = size(mul,2);
    
    intcof = 1./(1:n);
    res = intcof*mul';
end

