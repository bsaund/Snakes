function plotSimpleLinkage(vertices)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
clf('reset')

numVert = size(vertices,1);

for i = 2:numVert
    c = 'k';
    if(mod(i,2))
        c = 'b';
    end
    plot3(vertices(i-1:i,1), vertices(i-1:i,2), vertices(i-1:i,3),c,'LineWidth',10);%
    hold on
end
axis equal
   
b = numVert * 2 - 4;
axis([-b,b,-b,b,-b,b])

end

