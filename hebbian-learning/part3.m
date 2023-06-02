
delta = clf;
clear;

% SAVE_DIR = 'E:\matlab';'

num_patches = 10000;
num_images = 10;
limit = 2e-04; 
num_components = 6;
eta = 2*10^-10;

samples_per_image = num_patches/num_images;

%get training dataset
data = [];
data= [data extract_patches(imread('im.1.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.2.tif'),8,samples_per_image )];
data= [data extract_patches(imread('im.3.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.4.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.5.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.6.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.7.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.8.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.9.tif'),8,samples_per_image)];
data= [data extract_patches(imread('im.10.tif'),8,samples_per_image)];

%0 mean the data
%verify that we take mean of all patches and subtract and not
%individual patches and subtract

[xdim, ydim] =size(data)


data_mean = mean(data')';
scattermean = data_mean*ones(1,10000);
data = data - scattermean;


[xdim ydim] = size(data);

%hebbian learning using sanger's rule
w = randn(xdim, num_components);

%iterate until delta is smaller then limit
delta = 1;
numadjust = 0;
iteration = 0;

% slow version, ok for learning a few components  
% maybe there is a way to speed up the learning of all 64 components
% you can also use the while loop: while abs(delta) > limit
% here, we will just learn six neurons (j), printing out the weights every 30 iterations 
% of the data set, you may want to modify that.

for outerloop = 1:20
  for innerloop = 1:30
      
    for idy = 1:ydim
        xcur = data(:,idy);
        ycur = w'*xcur;
        w_delta = zeros(xdim, 6);
        for j = 1:6
            for i = 1:64
                term2 = dot(w(i,:), ycur); %   TASK  compute sum w_ik y_k
                term3 = dot(w(:,j)', w(:,j));
                w_delta(i,j) = eta*(ycur(j)*xcur(i) - ycur(j)*term2 - term3); %%  FILL IN LEARNING RULE 
            end
        end
        w = w + w_delta;
    end
    delta = sum(sum(abs(w_delta)))

  end
    %display results (all)
    figure
    colormap('gray');

    for idx = 1:6
        subplot(2,3, idx);
        z = w(:,idx);
        %contrast renormalization
        z = z - min(z);
        z = z / max(z);
        imagesc(reshape(z,8,8));
        set(gca, 'visible', 'off'); 
    end
    baseFileName = sprintf('3-%s.fig', string(outerloop));
    fullFileName = fullfile([pwd '/outputs/'], baseFileName);
    savefig(gcf,fullFileName);

end

% codes for taking Image 11 and uses 10 principal components to reconstruct it.
% one line of code commented out.

im = imread('im11.tif');
[x y] = size(im);

step = 8;

figure
colormap('gray');

results = zeros(x,y);
errors = [];

for idx = 0:(x/step)-1
    for idy = 0:(y/step)-1
        
        patch = im(((idx*8)+1):((idx+1)*8),((idy*8)+1):((idy+1)*8)); 
        
        patch =double( reshape(patch, 1,64));
        
        n_patch = zeros(64,1);
        %dot product and recreate patch
        for idcoeff = 1:num_components
             n_patch = n_patch + dot(patch, w(:,idcoeff))*w(:,idcoeff); %%   TASK: synthesized a new patch based on 10 PCs 
        end  
        
        patch = uint8(patch);
        diff = abs(uint8(n_patch)-patch');
        error = sum(diff)/sum(patch);
        errors = [errors error];

        %write back results
        n_patch = reshape(n_patch,8,8);
        results(((idx*8)+1):((idx+1)*8),((idy*8)+1):((idy+1)*8)) = n_patch;

    end
end
results = results - min(min(results));
results = results / max(max(results));
mpe = mean(errors);

imagesc(results);
title(sprintf('Recreated with PCA (%s)',string(num_components)),sprintf('mpe=%s', string(mpe)));


saveas(gcf,'3_reconstruct.png');


