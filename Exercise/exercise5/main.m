I = double(imread('2007_000032.jpg'));

[ h, w, nc ] = size(I);
[II_b, II_g, II_r] = integral_image(I);

heatMap = zeros(size(I(:,:)));
for y = 2:h
    disp([y h])
    for x = 2:w
      
        sumPredX = 0;
        sumPredY = 0;
        for treeIndex = 1:length(fileList(:,1))


            idx = 1;
            leaf = false;
            while ~leaf

            xOff0 = x0{1,treeIndex}(idx,1);
            yOff0 = y0{1,treeIndex}(idx,1);
            xOff1 = x1{1,treeIndex}(idx,1);
            yOff1 = y1{1,treeIndex}(idx,1);
            z = z0{1,treeIndex}(idx,1);
            sb= s{1,treeIndex}(idx,1);

            e0 = b(II_b, II_g, II_r , x + xOff0 , y + yOff0 , z , sb, w , h);
            e1 = b(II_b, II_g, II_r , x + xOff1 , y + yOff1 , z , sb, w , h);

            eval = e0-e1;

                
                if eval < threshold{1,treeIndex}(idx,1)
                    %move to left child
                    idx = cl{1,treeIndex}(idx,1);
                else
                    %move to right child
                    idx = cr{1,treeIndex}(idx,1);
                end

                if idx < 1
                    leaf = true;
                    idx = abs(idx);
                end

                idx = idx + 1;
            end

            predX = px{1,treeIndex}(idx,1);
            predY = py{1,treeIndex}(idx,1);

            sumPredX = sumPredX + predX;
            sumPredY = sumPredY + predY;

        end
        heatX = sumPredX / length(fileList(:,1));
        heatY = sumPredY / length(fileList(:,1));
        
        heatX = round(heatX + x);
        heatY = round(heatY + y);
        
        if heatX >= 1 && heatX <= w && heatY >= 1 && heatY <= h
            heatMap(heatY, heatX) = heatMap(heatY, heatX) + 1;
        end
        

    end
end 

fprintf('DOne');


