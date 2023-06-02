myst_imgs = load("mystery_images.mat").mystery_images;

figure
colormap('gray');
idx=1;
for img = myst_imgs
    subplot(2,3,idx);
    im = imagesc(img{:});
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    title(sprintf('%s',string(idx)));
    idx = idx+1;
end
saveas(gcf,'mystery_images.png');

% FASTICA(mixedsig) estimates the independent components from given
% multidimensional signals. Each row of matrix mixedsig is one
% observed signal.  FASTICA uses Hyvarinen's fixed-point algorithm,
% see http://www.cis.hut.fi/projects/ica/fastica/. Output from the
% function depends on the number output arguments:

mixedsig = zeros(numel(myst_imgs),numel(myst_imgs{1}));

idx=1;
for img = myst_imgs
    mixedsig(idx,:) = img{:}(:);
    idx = idx+1;
end

% [icasig, A, W] = FASTICA (mixedsig); the rows of icasig contain the
% estimated independent components, estimated separating
% matrix W and the corresponding mixing matrix A.

[dim1, dim2] = size(myst_imgs{1});
numruns=3;

ica_imgs = zeros(numruns, numel(myst_imgs), dim1*dim2);

for j = 1:numruns

    [icasig, A, W] = fastica(mixedsig);
    ica_imgs(j,:,:) = icasig;
end

save('1d_icasig.mat','icasig');
save('1d_A.mat','A');
save('1d_W.mat','W');

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

saveas(gcf,'ica.png');