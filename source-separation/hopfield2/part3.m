close all force;

%%
% increase epochs
clear
close all force;

% img_list = ["images/bike.jpg", "images/bird.jpg", "images/boat.jpg", "images/bottle.jpg", "images/cake.jpg", ...
%     "images/car.jpg", "images/cat.jpg", "images/chair.jpg", "images/dog.jpg", "images/elephant.jpg", ...
%     "images/face.jpg", "images/horse.jpg", "images/house.jpg", "images/plane.jpg", "images/plant.jpg", ...
%     "images/shoes.jpg", "images/sofa.jpg", "images/spider.jpg", "images/tree.jpg", "images/coat.jpg", ];

learning_rule = 'oja'; % hebbian, storkey, oja
numPatterns = 8;
size = 50;
custom_load = [1];
updatemod = 'all'; % random, all, checkerboard
updatepara = [40, 4];
inputmod = 'corrupt'; % corrupt, partial, full
noise = size*size*0.75;
occlude = size*0.1;
inputpara = [1, noise]; % [1], [1, noise], [1, occlude, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

%%
% FINAL PLOTS
% Compare epoch

root_dir = "outputs3";

crrpts = ["full", "noise_625", "noise_1250", "noise_1875", "occlude_25", "occlude_10", "occlude_5"];
% epochs = ["100", "500"];
plt_titles = ["full", "25% noise", "50% noise", "75% noise", "50% occlusion", "80% occlusion", "90% occlusion"];

figure
colormap('gray');

idx=1;
for crrpt =crrpts

    folder = "oja_numPatterns8_in-"+ crrpt + "_epochs100"+ "\";
    in_dir = root_dir + "\" + folder;
    
    Vss_fname = fullfile(in_dir, "Vss.png");
    Vss_image = imread(Vss_fname);
    subplot(4,7, idx);
    imagesc(Vss_image);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;
    
    Vfinal_fname = fullfile(in_dir, "Vfinal.png");
    Vfinal_image = imread(Vfinal_fname);
    subplot(4,7, idx+7);
    imagesc(Vfinal_image);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;

    T_fname = fullfile(in_dir, "T.png");
    T_image = imread(T_fname);
    subplot(4,7, idx+14);
    imagesc(T_image);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;

    chckpnt_fname = fullfile(in_dir, "checkpoints.png");
    chckpnt_img = imread(chckpnt_fname);
    subplot(4,7, idx+21);
    imagesc(chckpnt_img);
    axis off
    t = title(sprintf('in: %s', plt_titles(idx)));
    t.FontSize = 6;

    idx = idx+1;
end

saveas(gcf,'compare_corruptions.png');