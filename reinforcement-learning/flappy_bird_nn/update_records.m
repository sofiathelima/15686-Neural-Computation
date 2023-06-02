function [nn, RL] = update_records(nn, RL, ps, old_qvalues, dx, dy, reward, gameover)
    gamma = 0.9;

    % compute max Q(s', a')
    qvalue = forward(nn.network, dlarray([dx; dy], 'CB')); %[2,1] dim
    
    % compute y
    if (gameover)
        y = reward;
    else
        y = reward + gamma * max(qvalue);
    end
    
    a = ps(3);
    target_qvalues = old_qvalues(:);
    target_qvalues(a) = y;
    target_qvalues = reshape(target_qvalues, 1, 2);
    
    if (RL.burnin < RL.record_n)
        RL.burnin = RL.burnin + 1;
    end
    
    RL.records(:, RL.pointer) = [ps(1), ps(2), target_qvalues].'; % x, y, target_qvalues(1), target_qvalues(2) 
    RL.pointer = mod(RL.pointer, RL.record_n) + 1;

end