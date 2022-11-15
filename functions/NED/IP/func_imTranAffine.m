function imp = func_imTranAffine(im,p)
% Warp image im according to affine transform parameter p = [s_x,s_y,shear,rotation,tx,ty] 

Tmat    = [1,0,p(5);0,1,p(6);0,0,1];    % translation mat
Smat    = [p(1),0,0;0,p(2),0;0,0,1];    % scaling mat 
Shmat   = [1,p(3),0;0,1,0;0,0,1];       % shearing mat
Rmat    = [cosd(p(4)),-sind(p(4)),0;sind(p(4)),cosd(p(4)),0;0,0,1]; % rotation mat

% composite 4 mats to form final affine mat
affineMat = Shmat*Rmat*Smat*Tmat;

% change the transform center to the center of image
[height,width]  = size(im);
A               = affineMat(1:2,1:2);
t               = affineMat(1:2,3);
Xc              = 0.5*(1+width);
Yc              = 0.5*(1+height);
t_centered      = t+(eye(2)-A)*[Xc;Yc];
affineMat(1:2,3)=  t_centered;

[X,Y]           = meshgrid(1:width,1:height);
U               = affineMat(1,1)*X + affineMat(1,2)*Y + affineMat(1,3);
V               = affineMat(2,1)*X + affineMat(2,2)*Y + affineMat(2,3);
imp             = interp2(X,Y,im,U,V,'cubic',0);
