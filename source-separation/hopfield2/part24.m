close all force;

%%
close all force;
learning_rule = 'storkey'; % hebbian, storkey, oja
numPatterns = 10;
size = 50;
custom_load = [1];
updatemod = 'all'; % random, all, checkerboard
updatepara = [40, 4];
inputmod = 'partial'; % full, corrupt, partial
noise25 = size*size*0.25;
occlude50 = size*0.5;
inputpara = [1, occlude50, 10,10]; % [1], [1, noise25], [1, occlude50, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

%%
% FINAL PLOTS
% Compare test figures across learning rates
close all force
root_dir = "outputs24";
crrpts = ["full", "noise_625", "occlude_25"];
plt_titles = ["full", "25% noise", "50% occlusion"];
numPatterns = 2;

figure
colormap('gray');

for idx = 1:length(crrpts)

    folder = "storkey_numPatterns" + string(numPatterns) + "_in-" + crrpts(idx) + "\";
    in_dir = root_dir + "\" + folder;

    Vss_fname = fullfile(in_dir, "Vss.png");
    Vss_image = imread(Vss_fname);
    subplot(4,3, idx);
    imagesc(Vss_image);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;

    Vfinal_fname = fullfile(in_dir, "Vfinal.png");
    Vfinal_image = imread(Vfinal_fname);
    subplot(4,3, idx+3);
    imagesc(Vfinal_image);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;

    T_fname = fullfile(in_dir, "T.png");
    T_image = imread(T_fname);
    subplot(4,3, idx+6);
    imagesc(T_image);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;

    chckpnt_fname = fullfile(in_dir, "checkpoints.png");
    chckpnt_img = imread(chckpnt_fname);
    subplot(4,3, idx+9);
    imagesc(chckpnt_img);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;

end

saveas(gcf,sprintf('compare_in_numPttrns%s.png', string(numPatterns)));