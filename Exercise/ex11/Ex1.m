
img = imread('my_image.jpg');
figure
imagesc(img)
rect = round(getrect);

template_matching('NCC','Grayscale','Exhaustive',img,rect);
%template_matching('SSD','Grayscale','Exhaustive',img,rect);