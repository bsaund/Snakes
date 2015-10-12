function [collision, lastReachablePoint] = checkCollisionOnPath(snake, p0, p1, resolution, display)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


if(nargin < 5)
    display = false;
end

snake.setAngles(p0);
collision = snake.checkCollisions;
if(collision)
    lastReachablePoint = [];
    if(display)
        snake.plot()
    end
    return
end


diff = p1-p0;
numSteps = max(abs(diff))/resolution;

if(numSteps == 0)
    if(display)
        snake.plot()
    end
    lastReachablePoint = p0;
    return
end


for i = 0:numSteps
    snake.setAngles(p0 + diff*i/numSteps);
    if(snake.checkCollisions)
        collision = 1;
        break
    end
    lastReachablePoint = p0+diff*i/numSteps;
end

if(display)
    SnakeUtils.plotPath(snake, p0, lastReachablePoint, resolution/10);
end


end

