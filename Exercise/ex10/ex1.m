
close all;


I = imread(num2str(140,'sequence/2043_000%03d.jpeg'));
k=0;

figure;
imagesc(I);
rect = round(getrect);    


for i = 140:190
    
    I = imread(num2str(i,'sequence/2043_000%03d.jpeg'));
    roi = I(rect(2):rect(2)+rect(4), rect(1):rect(1)+rect(3), :);
    
    h = colorHist(roi);
    k=k+1;
    prob{k} = probMap(roi, h);
    
     bar3(prob{k})
     pause

    
end




