function plotPaths(snake, p, resolution)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

for i=2:size(p,1)
    SnakeUtils.plotPath(snake, p(i-1,:), p(i,:), resolution)
end

end
