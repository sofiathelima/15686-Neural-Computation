load("IMAGES.mat");

N = 5000;
num_ntrl_imgs = size(IMAGES, 3);
num_xtrct = N/num_ntrl_imgs;
xtrct_size = 12;
X = [];
for i = 1:num_ntrl_imgs
    X = [X extract_patches(IMAGES(:,:,i), xtrct_size, num_xtrct)];
end


% [icasig, A, W] = FASTICA (mixedsig); the rows of icasig contain the
% estimated independent components, W contains estimated separating
% matrix and A contains the corresponding mixing matrix.

[icasig, A, W] = fastica(X);

%%
figure('Position', [10 10 1000 1500])
colormap('gray');

idx=1;
for mixi = A
    subplot(xtrct_size, xtrct_size, idx);
    im = imagesc(reshape(mixi, xtrct_size, xtrct_size));
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    t = title(sprintf('ICA mix %s',string(idx)));
    t.FontSize = 5;
    idx = idx+1;
end

saveas(gcf,'ica_1e2.png');
