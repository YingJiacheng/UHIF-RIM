function Laplace_pyramid_new=pyramid_normalize(Laplace_pyramid)

num=numel(Laplace_pyramid);

for i=1:num
    IMAX              = max([Laplace_pyramid{i}(:)]);
    IMIN              = min([Laplace_pyramid{i}(:)]);
    Laplace_pyramid{i}(:,:,1)     = gray_scale_image(Laplace_pyramid{i}(:,:,1),IMIN,IMAX); % scale image to the same gray scales
    Laplace_pyramid{i}(:,:,2)     = gray_scale_image(Laplace_pyramid{i}(:,:,2),IMIN,IMAX);
    Laplace_pyramid_new{i}     = Laplace_pyramid{i};
  
end


end

