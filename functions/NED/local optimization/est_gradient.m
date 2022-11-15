function g = est_gradient(this,p)
% return the gradient of NED at affine transform parameter p.
% this.images(:,:,1) = fr1;
% this.images(:,:,2) = fr2;
% this.deriv_filter: drivative kernel in x direction

% warping image
warpI = affine_transform(this.images(:,:,2),p);

% gradient of warped image
[It,Ipx,Ipy] = partial_deriv_affine(this.images(:,:,1),this.images(:,:,2),p,this.deriv_filter);

% NED value
J = J_value(warpI,this.images(:,:,1));

% compute weight maps
w     = func_rho(It,1)-J*func_rho(warpI,1);


g         = zeros(6,1);
g(1)      = mean2(w.*this.X.*Ipx);
g(2)      = mean2(w.*this.Y.*Ipx);
g(3)      = mean2(w.*Ipx);
g(4)      = mean2(w.*this.X.*Ipy);
g(5)      = mean2(w.*this.Y.*Ipy);
g(6)      = mean2(w.*Ipy);

