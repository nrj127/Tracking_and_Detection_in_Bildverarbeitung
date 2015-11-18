function [ output_args ] = visualize( f,d,number )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    perm = randperm(size(f,2)) ;
	sel = perm(1:number);
    h1 = vl_plotframe(f(:,sel));
    h2 = vl_plotframe(f(:,sel));
    h3 = vl_plotsiftdescriptor(d(:, sel), f(:, sel));   
    set(h1,'color','k','linewidth', 3);
    set(h2,'color','y','linewidth', 2);
    set(h3,'color','g')




end

