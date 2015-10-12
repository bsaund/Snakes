function plotPath(snake, p0, p1, resolution)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
diff = p1-p0;
numSteps = max(abs(diff))/resolution;
snake.plot()

for i = 0:numSteps
    snake.setAngles(p0 + diff*i/numSteps);
    snake.plot()
    pause(.01*resolution);
end


end

