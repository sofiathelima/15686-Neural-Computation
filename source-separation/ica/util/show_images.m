function [  ] = show_images( ims, rows, cols, title, handler)

n = size(ims, 3);

set(0, 'CurrentFigure', handler);

for i=1:n
    subaxis(rows, cols, i, 'Spacing', .03, 'Padding', 0, 'Margin', 0);
    imshow(ims(:,:,i));
end

mtit(handler, title);