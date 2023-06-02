%Load images

x = [];
x = [x extract_patches(imread('im.1.tif'),8,500)];
x = [x extract_patches(imread('im.2.tif'),8,500)];
x = [x extract_patches(imread('im.3.tif'),8,500)];
x = [x extract_patches(imread('im.4.tif'),8,500)];
x = [x extract_patches(imread('im.5.tif'),8,500)];
x = [x extract_patches(imread('im.6.tif'),8,500)];
x = [x extract_patches(imread('im.7.tif'),8,500)];
x = [x extract_patches(imread('im.8.tif'),8,500)];
x = [x extract_patches(imread('im.9.tif'),8,500)];
x = [x extract_patches(imread('im.10.tif'),8,500)];

samples = x;

% Look at first 10 images for the first part
% x = [x extract_patches(imread('im.11.tif'),8,500)];

%get covariance matrix (transpose matrix such that cov produces correct result)
C_est = cov(transpose(x),1);
%singular value decomposition on covariance matrix
[U,S,V] = svd(C_est); %% FILL IN the computation of covariance matrix and svd here 

%display results (top 10)
figure
colormap('gray');
for idx = 1:10
    subplot(2,5,idx);
    z = U(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    img = imagesc(reshape(z,8,8));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0.5g',S(idx,idx)));


    %set(gca, 'visible', 'off'); 
end
saveas(gcf,'1-2b.png');

%display all eigenvectors as images 
figure
colormap('gray');

for idx = 1:64
    subplot(8,8, idx);
    z = U(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    imagesc(reshape(z,8,8));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0.5g',S(idx,idx)));
    %set(gca, 'visible', 'off'); 
end
saveas(gcf,'1-3a1.png');


% TASK: you have to deal with eigenvalues to answer the questions. 
fig1 = figure; % Open new figure window

eig_vals = diag(S);
subplot(2,1, 1)
bar(eig_vals); % Plot 
title('HW2 #1: Principal Component Analysis');
xlabel('PCs');
ylabel('eigen value');

eig_vals = diag(S);
subplot(2,1, 2)
var_exp = cumsum(eig_vals)./trace(S);
plot(var_exp);
xlabel('PCs');
ylabel('cumulative explained variance');

saveas(fig1,'1-3a2.png');

% codes for taking Image 11 and uses 10 principal components to reconstruct it.
% one line of code commented out.

im = imread('im11.tif');
[x y] = size(im);
numeigs = [10, 1, 6, 8, 4, 44];
step = 8;

figure
colormap('gray');

i=1;
for numeig=numeigs
    subplot(2,3, i);
    results = zeros(x,y);
    errors = [];

    for idx = 0:(x/step)-1
        for idy = 0:(y/step)-1
            
            patch = im(((idx*8)+1):((idx+1)*8),((idy*8)+1):((idy+1)*8)); 
            
            patch =double( reshape(patch, 1,64));
            
            n_patch = zeros(64,1);
            %dot product and recreate patch
            for idcoeff = 1:numeig
                 n_patch = n_patch + dot(patch, U(:,idcoeff))*U(:,idcoeff); %%   TASK: synthesized a new patch based on 10 PCs 
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
    title(sprintf('Recreated with PCA (%s)',string(numeig)),sprintf('mpe=%s', string(mpe)));

    i=i+1;
end

saveas(gcf,'1-3c.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%code for showing original image.

figure
colormap('gray');
imshow(im);
title('Original image');
saveas(gcf,'1-3b-original.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot a histogram of the projection of 1000 samples drawn.

rand_idx = randsample(1:size(samples,2),1000);
samples1000 = samples(:,rand_idx);
coefs = zeros(3,1000);
figure
for i = 1:3
    subplot(1,3,i)
    projs = [];
    for sample=samples1000
        patch =double( reshape(sample, 1,64));
        n_patch = dot(patch, U(:,i)); %%  project a new patch based on 1 PC
        projs = [projs n_patch];
    end
    sd = std(projs);
    histogram(projs)
    title({'Histogram of 1000', 'train projections', sprintf('PC # %s',string(i)), sprintf('std=%s',string(sd))});

    coefs(i,:) = projs;
end  
saveas(gcf,'1-3d-histograms.png');

%compute Pearson correlation between each three pairs of sets of coefficients.
figure
corrplot(transpose(coefs))
saveas(gcf,'1-3e-corr.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Repeat analysis for 16x16 patches.

x = [];
x = [x extract_patches(imread('im.1.tif'),16,500)];
x = [x extract_patches(imread('im.2.tif'),16,500)];
x = [x extract_patches(imread('im.3.tif'),16,500)];
x = [x extract_patches(imread('im.4.tif'),16,500)];
x = [x extract_patches(imread('im.5.tif'),16,500)];
x = [x extract_patches(imread('im.6.tif'),16,500)];
x = [x extract_patches(imread('im.7.tif'),16,500)];
x = [x extract_patches(imread('im.8.tif'),16,500)];
x = [x extract_patches(imread('im.9.tif'),16,500)];
x = [x extract_patches(imread('im.10.tif'),16,500)];

C_est = cov(transpose(x),1);
[U,S,V] = svd(C_est);

%display results (top 10)
figure
colormap('gray');
for idx = 1:10
    subplot(2,5,idx);
    z = U(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    img = imagesc(reshape(z,16,16));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0.5g',S(idx,idx)));

end
saveas(gcf,'1-3f-10PCs.png');

%display 64 eigenvectors as images 
figure
colormap('gray');

for idx = 1:64
    subplot(8,8, idx);
    z = U(:,idx);
    %contrast renormalization
    z = z - min(z);
    z = z / max(z);
    imagesc(reshape(z,16,16));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%0.5g',S(idx,idx)));
    %set(gca, 'visible', 'off'); 
end
saveas(gcf,'1-3f-64PCs.png');

% Variance explained
fig1 = figure; % Open new figure window

eig_vals = diag(S);
subplot(2,1, 1)
bar(eig_vals); % Plot 
title('HW2 #1: Principal Component Analysis');
xlabel('PCs');
ylabel('eigen value');

eig_vals = diag(S);
subplot(2,1, 2)
var_exp = cumsum(eig_vals)./trace(S);
plot(var_exp);
xlabel('PCs');
ylabel('cumulative explained variance');

saveas(fig1,'1-3f-expvar.png');

index = find(var_exp > 0.99);