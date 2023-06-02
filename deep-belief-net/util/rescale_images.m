function [ resized_data ] = rescale_images( data, height, width)
%RESCALE_IMAGES  resizes images (1 per row) in data

[n, p] = size(data);
p_new = height*width;
resized_data = zeros(n, p_new);

for i=1:n
    resized_data(i,:) = reshape(imresize(reshape(data(i,:), 28, 28),[height,width]),1,p_new);
end


end

