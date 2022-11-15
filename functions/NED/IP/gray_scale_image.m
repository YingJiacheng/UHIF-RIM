function  im_scaled = gray_scale_image(im,IMIN,IMAX)

im_scaled = (im - IMIN)./(IMAX-IMIN);
