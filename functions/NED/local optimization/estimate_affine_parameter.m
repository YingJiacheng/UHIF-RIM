function p = estimate_affine_parameter(fr1, fr2)

if size(fr1,3)>1
    fr1 = rgb2gray(fr1);
    fr2 = rgb2gray(fr2);

end

[m,n]=size(fr1);
[M,N]=size(fr2);
bin=M/m;

upsampled_fr1=Upsample(fr1,bin);
psf = fspecial('gaussian',3*bin/2-1,3*bin/8);
fr2_temp=imfilter(fr2, psf, 'circular', 'conv');
downsampled_fr2=fr2_temp(1:bin:end,1:bin:end);

    options.tol                     = 1e-6;
    options.itermax                 = 1000;
    options.minSize                 = 16;
    options.pyramid_spacing         = 1.5;
    options.display                 = true;
    options.deriv_filter            = [-0.5,0,0.5];
    options.deriv_filter_conj       = [0.5,0,-0.5];
    options.initial_affine_param    = [1,0,0,0,1,0]';
    pyramid_level1                  = 1+floor(log(m/options.minSize)/log(options.pyramid_spacing)); 
    pyramid_level2                  = 1+floor(log(n/options.minSize)/log(options.pyramid_spacing));
    pyramid_level3                  = 1+floor(log(M/m)/log(options.pyramid_spacing)); 
    pyramid_level4                  = 1+floor(log(N/n)/log(options.pyramid_spacing));
    levels1          = min(pyramid_level1,pyramid_level2);
    levels2          = min(pyramid_level3,pyramid_level4);
    options.pyramid_levels          = levels1+levels2;

IMAX              = max([fr1(:);downsampled_fr2(:)]);
IMIN              = min([fr1(:);downsampled_fr2(:)]);
images1(:,:,1)     = gray_scale_image(fr1,IMIN,IMAX); % scale image to the same gray scales
images1(:,:,2)     = gray_scale_image(downsampled_fr2,IMIN,IMAX);
smooth_sigma      = sqrt(options.pyramid_spacing)/sqrt(3);
hg                = fspecial('gaussian', 2*round(1.5*smooth_sigma)+1, smooth_sigma);
pyramid_images_1    = compute_image_pyramid(images1, hg, levels1, 1/options.pyramid_spacing);  

IMAX              = max([upsampled_fr1(:);fr2(:)]);
IMIN              = min([upsampled_fr1(:);fr2(:)]);
images2(:,:,1)     = gray_scale_image(upsampled_fr1,IMIN,IMAX); % scale image to the same gray scales
images2(:,:,2)     = gray_scale_image(fr2,IMIN,IMAX);
pyramid_images_2    = compute_image_pyramid(images2, hg, levels2, 1/options.pyramid_spacing);
pyramid_images = [pyramid_images_2;pyramid_images_1];


dx=[-1/2;0;1/2];
dy=[-1/2 0 1/2];


psf = fspecial('gaussian',5 , 2 );
for i=1:options.pyramid_levels
    dx_pyramid{i}=imfilter(pyramid_images{i}, dx, 'circular', 'conv');
    dy_pyramid{i}=imfilter(pyramid_images{i}, dy, 'circular', 'conv');
    detail_pyramid{i}=(dx_pyramid{i}.^2+dy_pyramid{i}.^2).^0.5;
 
end

   detail_pyramid = pyramid_normalize(detail_pyramid);

for k = options.pyramid_levels:-1:1
    if k == options.pyramid_levels
        p = options.initial_affine_param;
    else
        % Transfer affine parameter from lower layer to current layer
        options.itermax = ceil(options.itermax/options.pyramid_spacing);
        p(3) = p(3)*size(detail_pyramid{k},2)/size(detail_pyramid{k+1},2);
        p(6) = p(6)*size(detail_pyramid{k},1)/size(detail_pyramid{k+1},1);
    end
    
    % Generate copy of current layer settings
    small        = options;
    small.images = detail_pyramid{k};
    % Start estimate affine parameters on current layer
    sz          = [size(detail_pyramid{k},1),size(detail_pyramid{k},2)];
    [X,Y]       = meshgrid(1:sz(2),1:sz(1));
    x_shift  = (1+max(X(:)))/2;
    y_shift  = (1+max(Y(:)))/2;
    X = X - x_shift;
    Y = Y - y_shift;
    small.X     = X/max(X(:));
    small.Y     = Y/max(Y(:));
    converged   = false;
    iter        = 0;
    steplength  = 0.5/max(sz);
    while ~converged
        g = est_gradient(small,p);
        p = p + steplength*g/max(abs(g));
        residualError = max(abs(g));
        iter = iter + 1;
        converged = (iter>=small.itermax) || (residualError<small.tol);
    end
end


