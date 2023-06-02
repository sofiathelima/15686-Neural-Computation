close all force;

%%
% FINAL PLOTS
% Compare test figures across learning rules
rules = ["storkey", "hebbian", "oja"];
numPatterns = [3 4 5 6 10 20];
test_num = 3;

root_dir = "outputs22";


figure
colormap('gray');

idx=1;
for rule = rules
    for numPttrn = numPatterns

        folder = rule + "_numPatterns" + string(numPttrn) + "_test" + string(test_num) + "\";
        in_dir = root_dir + "\" + folder;
        fname = fullfile(in_dir, "Vfinal.png");
        
        image = imread(fname);
        
        subplot(3,6, idx);
        imagesc(image);
        axis off
        [t, s] = title(sprintf('Rule: %s', rule), sprintf('numPatterns: %s', string(numPttrn)));
        t.FontSize = 6;
        s.FontSize = 6;

        idx = idx+1;
    end
end

saveas(gcf,'compare_boat.png');

%%
% FINAL PLOTS
% % Compare test figures across learning rules
rules = ["storkey", "hebbian", "oja"];
numPatterns = [3 4 5 6 10 20];
test_num = 3;

root_dir = "outputs22";


figure
colormap('gray');

idx=1;
for rule = rules
    for numPttrn = numPatterns

        folder = rule + "_numPatterns" + string(numPttrn) + "_test" + string(test_num) + "\";
        in_dir = root_dir + "\" + folder;
        fname = fullfile(in_dir, "T.png");
        
        image = imread(fname);
        
        subplot(3,6, idx);
        imagesc(image);
%         set(gca, 'visible', 'off');
        axis off
        [t, s] = title(sprintf('Rule: %s', rule), sprintf('numPatterns: %s', string(numPttrn)));
        t.FontSize = 6;
        s.FontSize = 6;

        idx = idx+1;
    end
end

saveas(gcf,'compare_boatT.png');


%%
figure
colormap('gray');
img = imread("images/tree.jpg");
imagesc(img);
saveas(gcf,'tree.png');

a=dir([pwd '/images/*.jpg']);
disp(sum(arrayfun(@(a) ~isempty(a.name),a)));

%%
learning_rule = 'hebbian'; % hebbian, storkey, oja
numPatterns = 5;
size = 50;
custom_load = [1];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [3]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

%%
learning_rule = 'oja'; % hebbian, storkey, oja
numPatterns = 5;
size = 50;
custom_load = [1];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [3]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

%%
learning_rule = 'storkey'; % hebbian, storkey, oja
numPatterns = 20;
size = 50;
custom_load = [1];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [5]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);
%%
% outputs22_1
learning_rule = 'storkey'; % hebbian, storkey, oja
numPatterns = 2;
size = 50;
custom_load = ["images/bike.jpg", "images/face.jpg"];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [2]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

%%
% outputs22_2
learning_rule = 'storkey'; % hebbian, storkey, oja
numPatterns = 3;
size = 50;
custom_load = ["images/bike.jpg", "images/face.jpg", "images/bird.jpg"];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [3]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

%%
% outputs22_3
learning_rule = 'storkey'; % hebbian, storkey, oja
numPatterns = 4;
size = 50;
custom_load = ["images/bike.jpg", "images/face.jpg", "images/bird.jpg", "images/plant.jpg"];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [4]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

%%
% outputs22_4
clear
close all force;
learning_rule = 'storkey'; % hebbian, storkey, oja
numPatterns = 5;
size = 50;
custom_load = [1];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'full'; % corrupt, partial, full
inputpara = [3]; % [1, 20, 10,10]

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);