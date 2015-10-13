function path = findPath(snake, p0, pG)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

path = findPathRRT(snake, p0, pG);
path = prunePath(snake, path);
path = smoothPath(snake, path);

end

function path = prunePath(s, path)
notPruned = path
p = 2;
for ind = 2:(size(path,1) - 1)
    col = SnakeUtils.checkCollisionOnPath(s, path(p-1,:), path(p+1,:),10);
    if(~col)
        path(p,:) = [];
    else
        p = p+1;
    end
end

end

function path = smoothPath(s, path)
%Attempt to make all paths from the RRT more smooth.
numCords = size(path,2);
numPoints = size(path,1);
notSmoothed = path
progress = 1;
weightedMean = @(a,b,wa) a*wa + b*(1-wa);
weightings = ones(numPoints, numCords);

while(progress)
    progress = 0;
    for p = 2:(numPoints-1)
        for c = 1:numCords
            newX = weightedMean(path(p,c), mean(path([p-1,p+1],c)),...
                1-weightings(p,c));
            
            if( ~round((newX - path(p,c))/10))
                continue
            end
            
            newP = path(p,:);
            newP(c) = newX;
         
            
            col1 = SnakeUtils.checkCollisionOnPath(s, path(p-1,:), newP, 10);
            col2 = SnakeUtils.checkCollisionOnPath(s, newP, path(p+1), 10);
            
            if(~col1 && ~col1)
                path(p,c) = newX;
                progress = 1;
            else
                weightings(p,c) = .5*weightings(p,c);
            end
        end
    end
end

end

function path = findPathRRT(snake, p0, pG)
t = tree();
t=t.addnode(0, p0);
i = 0;
pathFound = 0;
while(~pathFound)
    [pI, isGoal] = genNewPoint(i, p0, pG);
    i = i + 1;
    [t, collision] = addPointToGraph(t, snake, pI);
    pathFound = isGoal && ~collision;
end

pathInd = t.findpath(1, length(t.Parent));
for i=1:numel(pathInd)
    path(i,:) = t.get(pathInd(i));
end

end

function [t, collision] = addPointToGraph(t, snake, pG)

%Assuming no collision at p, since the path 
%should have been checked. There might be numerical problems here though!!!
%Creates a new node in tree if closest is in the middle of a path.
[t, pCloseInd, ] = findClosestPoint(t, pG); 
pClose = t.get(pCloseInd);
[collision, pnew] = SnakeUtils.checkCollisionOnPath(snake, pClose, pG, 10);

%Don't add new identical points
if(max(abs(round(pnew-pClose))))
    t=t.addnode(pCloseInd, pnew); 
end
end

function [t, pCloseInd] = findClosestPoint(t, p)
minDist = inf;
minNodeIDs = [];

%Special case for first node, since there is no line.
if(numel(t.Parent) == 1)
    pCloseInd = 1;
    return;
end

% if(numel(t.Parent) > 18)
%     p
%     numel(t.Parent)
% end
    
for nodeID = 1:numel(t.Parent)
    for childID = t.getchildren(nodeID)
        p0=t.Node{nodeID};
        p1=t.Node{childID};
        d = distBetweenLineSegments(p0,p1,p,p);
        if(d < minDist)
            minDist = d;
            minNodeIDs = [nodeID, childID];
        end
    end
end

[~, pnew, ~, useBoundary, ~] = distBetweenLineSegments(...,
    t.Node{minNodeIDs(1)}, t.Node{minNodeIDs(2)}, p,p);
if(useBoundary)
    pCloseInd = minNodeIDs(useBoundary);
    return
end
   
[t, pCloseInd] = t.insertNode(minNodeIDs(2), pnew);

end


function [pX, isGoal] = genNewPoint(index, p0, pG)
isGoal = ~mod(index, 20);
if(isGoal)
    pX = pG;
    return
end
% pX = rand(size(pG)) * 180 - 90;
% pX = bound(randn(size(pG)) * 180 + p0, -90,90);
pX = randn(size(pG)) .* (pG - p0) + (pG + p0)/2 + randn(size(pG))*20;

pX = bound(pX, -90,90);
    
end