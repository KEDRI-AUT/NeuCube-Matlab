function imshowh(handle,I)
set(handle,'units','pixels');
pos=get(handle,'position');
img=imresize(I,[pos(4),pos(3)]);
imshow(img,'Parent',handle);