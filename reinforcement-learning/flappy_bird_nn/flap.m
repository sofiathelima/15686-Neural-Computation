function [a, qvalues] = flap(nn, dx, dy, train)
    input_sa = dlarray([dx ;dy], 'CB');
    
    p_sa = forward(nn.network, input_sa); % [2, 1] dimension
   	if (p_sa(1) > p_sa(2))
        a = 1;
    else
        a = 2;
    end
    
    
%     if train
%         % could add randomness to help explore
%         p = rand(1) > 0.1; % 10% chance to flip around
%         if p
%             a = 3 - a;
%         end
%     
%     end
    
    qvalues = p_sa;
    
end