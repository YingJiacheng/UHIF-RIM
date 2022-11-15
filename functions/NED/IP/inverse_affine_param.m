function pt = inverse_affine_param(p)
A = [p(1) p(2) p(3);p(4) p(5) p(6); 0 0 1];
B = inv(A)';
p = B(:);
pt = p(1:6);
