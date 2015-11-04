function [s, e] = makeSnakes()
n = 8;
s = Snakes.DummySnake(n);
e = Snakes.ErrorSnake(n);


hardcodedOffsets = [1,-1,1,-1,1,-1,1,-1];
% hardcodedErrors = zeros(1,n);
e.setOffsets(hardcodedOffsets);
end