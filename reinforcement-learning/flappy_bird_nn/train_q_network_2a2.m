function [nn, RL] = train_q_network(nn, RL)
    
    iterations = 10;
    bz = round(RL.record_n / iterations);
    index = randperm(RL.record_n);
    
    for iter=1:iterations
        batch_index = index((iter - 1) * bz + 1 : min(RL.record_n, iter * bz));
        
        batch_state = RL.records(1:2, batch_index); % 4, bz
        target = RL.records(3:4, batch_index);
        
        dl_batch_state = dlarray(batch_state, 'CB');
        dl_batch_target = dlarray(target, 'CB');
        
        networkGrad = dlfeval(@compute_gradient, nn.network, dl_batch_state, dl_batch_target);
        
        [nn.network.Learnables, nn.avgGradientsNetwork, nn.avgGradientsSquaredNetwork] = adamupdate(nn.network.Learnables, networkGrad, ...
            nn.avgGradientsNetwork, nn.avgGradientsSquaredNetwork, iter, nn.lr);
        
        nn.iteration = nn.iteration + 1;
    end
    fprintf("---- END OF CURRENT OPTIMIZATION  ------\n");

end


function [grad] = compute_gradient(network, dlx_batch, dlx_target)
    output = forward(network, dlx_batch);
    loss = mse(output, dlx_target);
    fprintf("Loss %.3f\n", extractdata(loss(1,1)));
    grad = dlgradient(loss, network.Learnables);
end