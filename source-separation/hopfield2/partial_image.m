function partial = partial_image(image, pixels,x,y)
%PARTIAL_IMAGE Summary of this function goes here
%   Detailed explanation goes here
len=sqrt(length(image));
image=reshape(image,len,len);
partial=ones(len);

partial(x:x+pixels,y:y+pixels)=image(x:x+pixels,y:y+pixels);
partial=reshape(partial,len^2,1);
end