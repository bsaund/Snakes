function xyzrpyDeg = tr2xyzrpyDeg(tr)
deg = 180/pi;
xyzrpyDeg = tr2xyzrpy(tr) .* [1,1,1,deg,deg,deg];
end