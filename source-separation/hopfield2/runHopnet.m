% function: runHopnet.m - simulates a Hopfield network
%
% returns the final network state
% parameters:
% update_method{ 
% random: per iteration, randomly choose a pixel and update it by outer rule.
% all: per iteration, update all pixels simultaneously
% checkerboard: per iteration, update certain pixels simultaneously (for example, for iteration 1, update pixels with odd id, for iteration 2, update pixels with even id ) 
% }
% T: weight matrix
% num_iterations: number of iterations
% V0: input image

function Vfinal = runHopnet(T,num_iterations,checkpoint_number,V0,update_method, save_dir)
checkpoint=num_iterations/checkpoint_number;
image_pixels=checkpoint_number*300;
fhi=figure('Units','pixels','Position', [100 100 image_pixels 300]);
fhi=figure();
colormap gray;

[N N]=size(T);
sz=sqrt(N);

tmp= V0;

if update_method=="random"
    for t=1:num_iterations  
        % pick a neuron i at random
        i=randi(N);
        % compute input U_i
        Ui = T(i,:)*tmp;
        % compute new state V_i
        tmp(i) = sign(Ui); %  STUDENT TASK:  update each random selected i-th node using the Hopfield dynamics.
        if mod(t,checkpoint)==0
%             colormap gray;
%             subplot(1,image_length,t/checkpoint);
            colormap gray;
            subplot(1,image_length,t/checkpoint);
            drawnow;
            imagesc(reshape(tmp,sz,sz));       
        end
    end
end
if update_method=="all"
    for t=1:num_iterations
        U = T*tmp; % STUDENT TASK  compute U, i.e. values of all the nodes U in the network in one simultaneously.
%         tmp=U;
        tmp = sign(U);
        if mod(t,checkpoint)==0
%             colormap gray;
%             subplot(1,checkpoint_number,t/checkpoint);
            colormap gray;
            subplot(1,checkpoint_number,t/checkpoint);
            imagesc(reshape(tmp,sz,sz));
        end
    end
end
saveas(gcf,fullfile(save_dir, 'checkpoints.png'));

if update_method=="checkerboard"
    for t=1:num_iterations
        % STUDENT TASK:  update U as in the “all” case, except now that you follow a checkerboard pattern. Update only 1 quarter of U in each iteration.
        if mod(t,checkpoint)==0
%             colormap gray;
%             subplot(1,checkpoint_number,t/checkpoint);
            colormap gray;
            subplot(1,checkpoint_number,t/checkpoint);
            imagesc(reshape(tmp,sz,sz));       
        end
    end
end 

Vfinal = tmp;
end