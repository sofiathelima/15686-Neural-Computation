close all force;

%%
% FINAL PLOTS
% Compare test figures across learning rates
root_dir = "outputs23";

figure('Position', [10 10 1000 400])
colormap('gray');

for lr = 1:8

    folder = "oja_numPatterns3_updates40-4_lr" + string(lr) + "\";
    in_dir = root_dir + "\" + folder;

    Vfinal_fname = fullfile(in_dir, "Vfinal.png");
    Vfinal_image = imread(Vfinal_fname);
    subplot(3,8, lr);
    imagesc(Vfinal_image);
    axis off
    t = title(sprintf('lr: %s', string(lr)));
    t.FontSize = 6;

    T_fname = fullfile(in_dir, "T.png");
    T_image = imread(T_fname);
    subplot(3,8, lr+8);
    imagesc(T_image);
    axis off
    t = title(sprintf('lr: %s', string(lr)));
    t.FontSize = 6;

    chckpnt_fname = fullfile(in_dir, "checkpoints.png");
    chckpnt_img = imread(chckpnt_fname);
    subplot(3,8, lr+16);
    imagesc(chckpnt_img);
    axis off
    t = title(sprintf('lr: %s', string(lr)));
    t.FontSize = 6;

end

saveas(gcf,'compare_lr.png');
%%
close all force
learning_rule = 'oja'; % hebbian, storkey, oja
numPatterns = 3;
size = 50;
custom_load = ["images/bike.jpg", "images/face.jpg"];
updatemod = 'all'; % random, all, checkerboard
updatepara = [40, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [1]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

