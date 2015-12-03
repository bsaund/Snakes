function [s, e] = makeSnakes()
n = 8;
s = Snakes.DummySnake(n);
e = Snakes.ErrorSnake(n);


hardcodedOffsets = [1,-1,1,-1,1,-1,1,-1];
% hardcodedOffsets = zeros(1,n);
hardcodedScalings = [1.01, .99, 1.01, .99, 1.01, .99, 1.01, .99];

hardcodedTransformOffsets = [...
    .1, .1, .1, .01, .01, .01;
    .1, .1, .1, .01, .01, .01;
    .1, .1, .1, .01, .01, .01;
    .1, .1, .1, .01, .01, .01;
    .1, .1, .1, .01, .01, .01;
    .1, .1, .1, .01, .01, .01;
    .1, .1, .1, .01, .01, .01;
    .1, .1, .1, .01, .01, .01;];

e.setOffsets(hardcodedOffsets);
% e.setScalings(hardcodedScalings);
% e.setTransformOffsets(hardcodedTransformOffsets);
end