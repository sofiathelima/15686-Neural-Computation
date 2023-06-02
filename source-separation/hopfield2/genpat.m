% genpat.m - script to generate a pattern with the mouse
%
% click with left button to toggle position on or off.
% middle or right button quits
% 
% the resulting pattern, 'pat',  is a NxN array of +1's and -1's
% that is reshaped to an N^2 element vector

N=50;

pat=zeros(N);

h=imagesc(pat,'EraseMode','none'); 
axis square, grid

done=0; 
while ~done
  [x y button]=ginput(1);
  if button==1
    x=floor(x+0.5);
    y=floor(y+0.5);
    pat(y,x)=1-pat(y,x);
  else
    done=1;
  end
  set(h,'CData',pat);
end

pat=2*pat-1;

pat=reshape(pat,N^2,1);
save('mypattern.mat', 'pat');