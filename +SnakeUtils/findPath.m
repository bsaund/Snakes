function [ output_args ] = findPath(snake, p0, pG)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

path = findPathRRT(snake, p0, pG);

end

function path = findPathRRT(snake, p0, pG)
t = tree();
t.addNode(0, p0);
i = 0;
pathFound = 0
while(~pathFound)
    [pI, isGoal] = genNewPoint(i, pG);
    i = i + 1;
    [t, collision] = addPointToGraph(t, snake, pI);
    pathFound = isGoal && ~collision;
end

path = t.findPath(1, length(t.Parent));

end

function [t, collision] = addPointToGraph(t, snake, pG)

%Assuming no collision at p, since the path 
%should have been checked. There might be numerical problems here though!!!
%Creates a new node in tree if closest is in the middle of a path.
[t, pCloseInd, pClose] = findClosestPoint(t, p); 
[collision pnew] = SnakeUtils.checkCollisionOnPath(snake, pClose, pG, 10);
t.addnode(pCloseInd, pnew); 
end

function [t, pCloseInd, pClose] = findClosestPoint(t, p)
minDist = inf;
minNodeIDs = [];
    
for nodeID = t.Parent
    for childID = t.getchildren(nodeID)
        p0=t.Node{nodeID};
        p1=t.Node{childID};
        d = 
    end
end

end


function [pX isGoal] = genNewPoint(index, pG)
if( ~mod(index, 100))
    pX = pG;
    return
end
pX = rand(size(pG)) * 180 - 90;
    
end