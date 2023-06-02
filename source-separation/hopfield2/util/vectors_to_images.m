function [ images ] = vectors_to_images( vectors, image_dim1, image_dim2 )
%VECTORS_TO_IMAGES Summary of this function goes here
%   Detailed explanation goes here

[n, p] = size(vectors);

if(image_dim1*image_dim2 ~= p)
    error(['The product of the dimensions of the image does not equal '...
            'the number of pixels in the data.  '...
            'Make sure the following is true of the parameters: '...
            'image_dim1*image_dim2=size(vectors,2)']);
end

%images = zeros(image_dim1,image_dim2,n);

images = reshape(vectors', image_dim1, image_dim2, n);

for i=1:n
    images(:,:,i) = images(:,:,i)';
end


end

