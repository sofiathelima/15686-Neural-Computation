function [] = plotTrajectory(pos,replay_time_indiv,decoded_locations)

replay_recon = 1;

temp_length = size(decoded_locations,1);
colour_vector = 1:(64/(temp_length+7)):64;
colour_vector = round(colour_vector);

temp_colourmap = colormap(cool);
hold on;
if (replay_recon==1)    
    plot(pos(:,1),pos(:,2),'.','Color',[0.8 0.8 0.8]);
    plot(pos(replay_time_indiv(1):replay_time_indiv(2),1),pos(replay_time_indiv(1):replay_time_indiv(2),2),'kx');
    for i=1:temp_length
        plot(decoded_locations(i,1),decoded_locations(i,2),'.','Color',temp_colourmap(colour_vector(i),:));
    end
else
    plot(pos(1:replay_time_indiv(1),1),pos(1:replay_time_indiv(1),2),'.','Color',[0.8 0.8 0.8]);
    plot(pos(replay_time_indiv(1):replay_time_indiv(2),1),pos(replay_time_indiv(1):replay_time_indiv(2),2),'b.');
    plot(decoded_locations(:,1),decoded_locations(:,2),'rx');
end

hold off;

end