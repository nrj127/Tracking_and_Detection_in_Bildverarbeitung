clear all;
temp_new = [];
for i= 1:10
    temp = num2str(i-1);
    temp_new = [temp_new temp];
    
end

temp1 = 'Tree';
temp2 = '.txt';
temp3 = '0';
FILE = [];
for i = 1:10
  file = strcat(temp1,temp_new(i),temp2);
  FILE = [FILE;file];
end

for i = 1:10
f = fopen(FILE(i,:),'r');
tree{i} =  textscan(f,'%f %f %f %f %f %f %f %f %f %f %f');
end

for i = 1:10
internal_nodes{i} = tree{1,i}{1,1}(1,1);
id_node{i} = tree{1,i}{1,1}(2:internal_nodes{i}+1,1);
cl{i} =      tree{1,i}{1,2}(2:internal_nodes{i}+1,1);
cr{i} =       tree{1,i}{1,3}(2:internal_nodes{i}+1,1);
threshold{i} =  tree{1,i}{1,4}(2:internal_nodes{i}+1,1);
x0{i} =  tree{1,i}{1,5}(2:internal_nodes{i}+1,1);
y0{i} =  tree{1,i}{1,6}(2:internal_nodes{i}+1,1);
z0{i} =  tree{1,i}{1,7}(2:internal_nodes{i}+1,1);
x1{i} =  tree{1,i}{1,8}(2:internal_nodes{i}+1,1);
y1{i} =  tree{1,i}{1,9}(2:internal_nodes{i}+1,1);
z1{i} =  tree{1,i}{1,10}(2:internal_nodes{i}+1,1);
s{i}  =  tree{1,i}{1,11}(2:internal_nodes{i}+1,1);
m{i}  =  tree{1,i}{1,1}(internal_nodes{i}+2,1);
j{i}  =  tree{1,i}{1,1}(internal_nodes{i}+3 :internal_nodes{i}+3 + m{i}-1,1);
px{i} =  tree{1,i}{1,2}(internal_nodes{i}+3: internal_nodes{i}+3 + m{i}-1,1);
py{i} =  tree{1,i}{1,3}(internal_nodes{i}+3:internal_nodes{i}+3 + m{i}-1,1)

end
internal_nodes = (cell2mat(internal_nodes));
internal_nodes = internal_nodes';

%i c L c R t x 0 y 0 z 0 x 1 y 1 z 1 s


