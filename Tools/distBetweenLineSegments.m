function [d, pSeg1, pSeg2] = distBetweenLineSegments(p0,p1,p2,p3)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

p0 = p0';
p1 = p1';
p2 = p2';
p3 = p3';

dim = size(p0,1);
v0 = p1-p0;
v2 = p3-p2;

Proj0 = eye(dim) - v0 * v0' / (v0' * v0);
Proj2 = eye(dim) - v2 * v2' / (v2' * v2);


v = Proj2 * Proj0 * (p2-p1);



end

