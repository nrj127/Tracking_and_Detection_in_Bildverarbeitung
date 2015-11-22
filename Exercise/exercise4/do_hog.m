function [ output_args ] = do_hog(object_image,test_image )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


run matconvnet/matlab/vl_setupnn.m;
cell_size = 8;




object_image = imresize(object_image,1/8);
object_image = single(rgb2gray(object_image));


hog = vl_hog(object_image,cell_size); % scene image
image = vl_hog('render', hog);
scale = 0.3;

%figure(12)
%imshow(image)


bs = 0;
test_image = imresize(test_image,1/4);
test_image = single(rgb2gray(test_image));


hog1 = vl_hog(test_image,cell_size); % test image
image1 = vl_hog('render', hog1);

%figure(13)
%imshow(image1)


scores = vl_nnconv(hog1,hog,[]);
max_score = max(max(scores));

if(max_score > bs)
     bs = max_score;
     bs1 = scores;
     bh =   hog ;
     bi = test_image;
end



[y0, x0] = ind2sub(size(bs1), find(bs1 == bs));
 pos = [x0 y0 size(hog, 2) size(hog, 1)] * cell_size;
            
figure(3)
imshow(bi/255);
hold on;
rectangle('Position', pos, 'EdgeColor', 'r', 'LineWidth', 3);
text(pos(1), pos(2)+pos(4)/2, num2str(max_score), 'Color', 'g');

end

