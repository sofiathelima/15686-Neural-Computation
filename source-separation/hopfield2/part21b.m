close all force;

% mytest(learning_rule, numPatterns, size, custom load, updatemod, 
% updatepara, inputmod, inputpara)

% e.g. mytest('hebbian', 2, 50, [“images/bike.jpg”, “images/car.jpg”], 'random', [10000, 1000], 'corrupt', [1, 20, 10,10])
% e.g. mytest(‘oja’, 2, 50, [1], 'random', [10000, 1000], 'corrupt', [1, 20, 10,10])
% e.g. mytest(‘storkey’, 2, 50, [1], ‘full’, [10000, 1000], 'corrupt', [1, 20, 10,10])

% mytest('storkey', 2, 50, ["images/bike.jpg", "images/face.jpg"],'random', [10000, 1000], 'corrupt', [1, 20, 10,10])

learning_rule = 'storkey'; % hebbian, storkey, oja
numPatterns = 2;
size = 50;
custom_load = ["images/bike.jpg", "images/face.jpg"];
updatemod = 'all'; % random, all, checkerboard
updatepara = [10, 4];
inputmod = 'corrupt'; % corrupt, partial, full
inputpara = [1, 20];

mytest(learning_rule, numPatterns, size, custom_load, updatemod, updatepara, inputmod, inputpara);

