% load source images from part a
load("mystery_images.mat");
[dim1, dim2] = size(mystery_images{1});

ica_sig = matfile("1d_icasig.mat");
icasig = ica_sig.icasig;

src_imgs = zeros(size(icasig, 1), dim1, dim2);

figure('Position', [10 10 1500 200])
colormap('gray');
idx=1;
for img = icasig.'
    subplot(1,6,idx);
    img = reshape(img, dim1, dim2);
    im = imagesc(img);
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('source %s',string(idx)));

    src_imgs(idx,:,:) = img;
    idx = idx+1;
end
saveas(gcf,'source_images_1d.png');

%%
% Create mixtures

rand_as = rand(2,1);
Imix1 = src_imgs(1,:,:).*rand_as(1) + src_imgs(2,:,:).*(1-rand_as(1));
Imix2 = src_imgs(1,:,:).*rand_as(2) + src_imgs(2,:,:).*(1-rand_as(2));

mix_imgs = [Imix1; Imix2];

figure
colormap('gray');
for idx = 1:size(mix_imgs,1)
    subplot(1,size(mix_imgs,1),idx);
    mix_img = squeeze(mix_imgs(idx,:,:));
    im = imagesc(mix_img);
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('mix %s',string(idx)));
end
saveas(gcf,'mixture_images_1d.png');

%%
% FASTICA(mixedsig) estimates the independent components from given
% multidimensional signals. Each row of matrix mixedsig is one
% observed signal.  FASTICA uses Hyvarinen's fixed-point algorithm,
% see http://www.cis.hut.fi/projects/ica/fastica/. Output from the
% function depends on the number output arguments:

mixedsig = zeros(size(mix_imgs, 1),numel(mix_imgs(1,:,:)));

for idx = 1:size(mixedsig,1)
    mix_img = mix_imgs(idx,:,:);
    mixedsig(idx,:) = mix_img(:);
end

% [icasig, A, W] = FASTICA (mixedsig); the rows of icasig contain the
% estimated independent components, estimated separating
% matrix W and the corresponding mixing matrix A.

numruns=3;

ica_imgs = zeros(numruns, size(mix_imgs,1), dim1*dim2);
figure
for j = 1:numruns

    [icasig, A, W] = fastica(mixedsig);
    ica_imgs(j,:,:) = icasig;
end

figure
colormap('gray');

jdx=1;
for ica_run_idx = 1:size(ica_imgs,1)
    ica_run = squeeze(ica_imgs(ica_run_idx,:,:));
    idx=1;
    for ica_im = ica_run.'
        subplot(numruns, size(icasig,1), jdx);
        im = imagesc(reshape(ica_im, dim1, dim2));
        set(gca,'xticklabel',[]);
        set(gca,'yticklabel',[]);
        title(sprintf('ICA source %s',string(idx)));
        idx = idx+1;
        jdx = jdx+1;
    end
end

saveas(gcf,'ica_1d.png');

%%
% Compare mixing weights and recovered mixing weights

figure
subplot(1,2,1)
X = categorical({'a1','a2','b1','b2'});
X = reordercats(X,{'a1','a2','b1','b2'});
Y = [rand_as(1) 1-rand_as(1) rand_as(2) 1-rand_as(2)];
bar(X, Y)
title('Mixing weights')

subplot(1,2,2)
X = categorical({'a1','a2','b1','b2'});
X = reordercats(X,{'a1','a2','b1','b2'});
% Nw = normalize(W,2,"norm",1);
Y = W(:);
bar(X, Y)
title('Estimated separating matrix')

saveas(gcf,'mixW_1d.png');