%  p0 = [90,90,-70,-90,10,90,-70,-10];
%  pG = [0,0,-70,-90,40,90,-70,-90];
%  SnakeUtils.checkCollisionOnPath(s, p0, pG,10,1)
%  pause(1)
%  SnakeUtils.checkCollisionOnPath(s, pG, p0, 10, 1)
 
 
 
%  %Simple
%  p0 = [0,0,0,0,0,0,0,0];
%  pG = [90,90,90,90,90,90,90,90];
%  SnakeUtils.checkCollisionOnPath(s, p0, pG,10,1)
 
p0 = [1, 0,0];
p1 = [1, .9,0];                          
q0 = [.9,1,1];
% q1 = [0,1,1];                           
q1 = [.9,1,1];
 
[d, a, b] = DistBetween2Segment(p0,p1,q0,q1)
[d, pseg1, pseg2, b1, b2] = distBetweenLineSegments(p0, p1, q0, q1) 
