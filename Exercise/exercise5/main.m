temp_new = [];
for i= 1:10
    temp = num2str(i);
    temp_new = [temp_new temp];
    
end
temp1 = 'Tree';
temp2 = '.txt';

for i = 1:10
    file(i) = strcat(temp1,temp_new(i),temp2);
end

fileId0 = fopen('Tree0.txt','r')
fileId1 = fopen('Tree1.txt','r')
fileId2 = fopen('Tree2.txt','r')
fileId3 = fopen('Tree3.txt','r')
fileId4 = fopen('Tree4.txt','r')
fileId5 = fopen('Tree5.txt','r')
fileId6 = fopen('Tree6.txt','r')
fileId7 = fopen('Tree7.txt','r')
fileId8 = fopen('Tree8.txt','r')
fileId9 = fopen('Tree9.txt','r')

formatSpec = '%f';

tree0 =  textscan(fileId0,'%f %f %f %f %f %f %f %f %f %f %f');
tree1 =  textscan(fileId1,'%f %f %f %f %f %f %f %f %f %f %f');
tree2 =  textscan(fileId2,'%f %f %f %f %f %f %f %f %f %f %f');
tree3 =  textscan(fileId3,'%f %f %f %f %f %f %f %f %f %f %f');
tree4 =  textscan(fileId4,'%f %f %f %f %f %f %f %f %f %f %f');
tree5 =  textscan(fileId5,'%f %f %f %f %f %f %f %f %f %f %f');
tree6 =  textscan(fileId6,'%f %f %f %f %f %f %f %f %f %f %f');
tree7 =  textscan(fileId7,'%f %f %f %f %f %f %f %f %f %f %f');
tree8 =  textscan(fileId8,'%f %f %f %f %f %f %f %f %f %f %f');
tree9 =  textscan(fileId9,'%f %f %f %f %f %f %f %f %f %f %f');

tree0_nodes = tree0{1,1}(1,1);
tree1_nodes= tree1{1,1}(1,1);
tree2_nodes= tree2{1,1}(1,1);
tree3_nodes= tree3{1,1}(1,1);
tree4_nodes= tree4{1,1}(1,1);
tree5_nodes= tree5{1,1}(1,1);
tree6_nodes= tree6{1,1}(1,1);
tree7_nodes= tree7{1,1}(1,1);
tree8_nodes= tree8{1,1}(1,1);
tree9_nodes= tree9{1,1}(1,1);


