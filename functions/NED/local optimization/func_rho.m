function y = func_rho(x,order,epsilon)

if nargin <= 2
    epsilon = 0.01;
end
if order == 0
    y = sqrt(x.^2 + epsilon^2);
    y = sum(y(:));
elseif order == 1
    y = x./sqrt(x.^2 + epsilon.^2);
else
    error('wrong order!');
end
