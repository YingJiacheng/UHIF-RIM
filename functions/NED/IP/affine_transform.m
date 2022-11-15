function It = affine_transform(im,p)
pt      = inverse_affine_param(p);
height  = size(im,1);
width   = size(im,2);
[X,Y]   = meshgrid(1:width,1:height);
x_shift =  (1 + width)/2;
y_shift =  (1 + height)/2;
X       = X - x_shift;
Y       = Y - y_shift;
U       = pt(1)*X + pt(2)*Y + pt(3)+ x_shift;
V       = pt(4)*X + pt(5)*Y + pt(6)+ y_shift;
X       = X + x_shift;
Y       = Y + y_shift;
It      = zeros(size(im));
for k = 1:size(im,3)
    %It(:,:,k) = interp2(X,Y,im(:,:,k),U,V,'linear',0);
    It(:,:,k) = interp2(X,Y,im(:,:,k),U,V,'cubic',0);
end

