  p0 = [-50,-70,70,-90,-40,90,0,-90];
  pG = [-50,-70,-70,-90,0,90,0,-60];
%   p0 = [90,90,-70,-90,10,90,-70,-10];
%   pG = [0,0,-70,-90,40,90,-70,-90];
%p0 = [0,0,-70,-90,40,90,0,-10,0,90,0,-90,-90,90,0,0];
%pG = [0,0,-70,-90,40,90,0,-10,0,90,0,-90,90,90,0,0];
% SnakeUtils.checkCollisionOnPath(s, p0, pG,10,1)
% pause(1)
% SnakeUtils.checkCollisionOnPath(s, pG, p0, 10, 1)

%  dbstop in findPath.m

%This is a dumb modification for demonstrating git

%  %Simple
%  p0 = [0,0,0,0,0,0,0,0];
%  pG = [90,90,90,90,90,90,90,90];
%  [c, pNew] = SnakeUtils.checkCollisionOnPath(s, p0, pG,10,1)
path = SnakeUtils.findPath(s, p0, pG)
SnakeUtils.plotPaths(s,path,10);

% p0 = [1, 0,0];
% p1 = [1, .9,0];
% q0 = [.9,1,1];
% % q1 = [0,1,1];
% q1 = [.9,1,1];
%
% [d, a, b] = DistBetween2Segment(p0,p1,q0,q1)
% [d, pseg1, pseg2, b1, b2] = distBetweenLineSegments(p0, p1, q0, q1)


for(i = 1:size(path,1))
    s.setAngles(path(i,:));
    SnakeUtils.writeToPhysicalSnake(s);
    pause(3);
end
