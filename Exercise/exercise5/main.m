I = double(imread('2007_000032.jpg'));

[ h, w, nc ] = size(I);
[II_b, II_g, II_r] = integral_image(I);

s=2;
sumPredX = zeros(size(I(:,:)));
sumPredY = zeros(size(I(:,:)));

for treeIndex = 1:length(fileList(:,1))
    intNodes = internal_nodes(treeIndex);
    for x = 2:w
        for y = 2:h
            for k = 1:intNodes
            xOff0 = x0{1,treeIndex}(k,1);
            yOff0 = y0{1,treeIndex}(k,1);

            xOff1 = x1{1,treeIndex}(k,1);
            yOff1 = y1{1,treeIndex}(k,1);

            z = z0{1,treeIndex}(k,1);
            e0 = b(II_b, II_g, II_r , x + xOff0 , y + yOff0 , z , s, w , h);
            e1 = b(II_b, II_g, II_r , x + xOff1 , y + yOff1 , z , s, w , h);

            eval = e0-e1;
            predX = 0;
            predY=0;
                if eval < threshold{1,treeIndex}(k,1)
                    %move to left child
                    leftChild = cl{1,treeIndex}(k,1);
                    if( leftChild < 1)
                        leftChild = abs(leftChild);
                    end
                        predX = px{1,treeIndex}(leftChild,1);
                        predY = py{1,treeIndex}(leftChild,1);                    
                else
                    %move to right child
                    rightChild = cr{1,treeIndex}(k,1);
                    if( rightChild < 1)
                        rightChild = abs(rightChild);
                    end
                        predX = px{1,treeIndex}(rightChild,1);
                        predY = py{1,treeIndex}(rightChild,1);
                    
                end
                
                sumPredX(y,x) = sumPredX(y,x) + predX;
                sumPredY(y,x) = sumPredY(y,x) + predY;
            end
        end
    end
end 

fprintf('DOne');


