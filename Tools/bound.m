function x = bound(x, minVal, maxVal)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x = min(maxVal, max(minVal, x));
end

