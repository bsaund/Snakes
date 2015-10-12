function [d, pSeg1, pSeg2, isOnBoundary1, isOnBoundary2] = ...
    distBetweenLineSegments(p1_0,p1_1,p2_0,p2_1)
%UNTITLED12 Summary of this function goes here
%   isOnBoundary return 0 if a middle point is closest, 1 if px_0
%   is closest, and 2 if px_1 is closest

p1_0 = p1_0';
p1_1 = p1_1';
p2_0 = p2_0';
p2_1 = p2_1';

if(min(p1_0 == p1_1))% || max(p2_0 == p2_1))
    error('Line cannot be described by identical points');
end


dim = size(p1_0,1);
v1 = p1_1-p1_0;
v2 = p2_1-p2_0;
vLine1_2 = p2_0 - p1_0;

Proj1 = eye(dim) - v1 * v1' / (v1' * v1);
Proj2 = eye(dim) - v2 * v2' / (v2' * v2);

v = Proj2 * Proj1 * (vLine1_2); %This is the vector between the lines

ProjPerp = eye(dim) - v * v'/(v' * v);
p1_closest = p1_0 + v1 * v1' * vLine1_2/(v1' * v1);
p2_closest = p2_0 + v2 * v2' * (-vLine1_2)/(v2' * v2);

f1 = (p1_closest - p1_0)./v1;
f2 = (p2_closest - p2_0)./v2;

f1 = mean(f1(~isnan(f1))); %mean is not necessary (just convenient)
f2 = mean(f2(~isnan(f2))); %all non-nan values will be the same

% isOnBoundary1 = (f1 <= 0) || (f1 >= 1);
% isOnBoundary2 = (f2 <= 0) || (f1 >= 1);
% isOnBoundary1 = f1;
% isOnBoundary2 = f2;
isOnBoundary1 = max([0, f1 <= 0, 2*(f1 >= 1)]);
isOnBoundary2 = max([0, f2 <= 0, 2*(f2 >= 1)]);



pSeg1 = p1_0 + min(1,max(0,f1)) * v1;
pSeg2 = p2_0 + min(1,max(0,f2)) * v2;

d = norm(pSeg1 - pSeg2);


end

