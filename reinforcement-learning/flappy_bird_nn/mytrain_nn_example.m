clear all;
x = rand(30, 1000);
dlx = dlarray(x, 'CB');

network = layerGraph([
    featureInputLayer([30], 'Name', 'Input'),
    fullyConnectedLayer(40, 'Name', 'fnn1'),
    reluLayer('Name', 'relu1'),
    fullyConnectedLayer(30, 'Name', 'fnn2'),
    reluLayer('Name', 'relu2'),
    fullyConnectedLayer(2, 'Name', 'fnn3' ),
    sigmoidLayer('Name', 'sig')
]);
network = dlnetwork(network);

executionEnvironment = "auto";
lr = 0.001;
bz=10;
input_dim = 30;


avgGradientsNetwork = [];
avgGradientsSquaredNetwork = [];

for iteration = 1:200
    
    idx = mod(iteration, floor(1000/bz))+1;
    dlx_batch = dlx(:, idx * bz: (idx + 1) * bz);
    
    myGrad = dlfeval(@compute_gradient, network, dlx_batch);
    [network.Learnables, avgGradientsNetwork, avgGradientsSquaredNetwork] = adamupdate(network.Learnables, myGrad, ...
        avgGradientsNetwork, avgGradientsSquaredNetwork, iteration, lr);
end



function grad = compute_gradient(network, dlx_batch)
    output = forward(network, dlx_batch);
    loss = sum(output, 'all');
    fprintf("Loss %.3f\n", extractdata(loss(1,1)));
    grad = dlgradient(loss, network.Learnables);
end