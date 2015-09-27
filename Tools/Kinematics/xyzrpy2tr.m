%RPY2TR	Roll/pitch/yaw to homogenous transform
%
%	RPY2TR([R P Y])
%	RPY2TR(R,P,Y) returns a homogeneous tranformation for the specified
%	roll/pitch/yaw angles.  These correspond to rotations about the
%	Z, Y, X axes respectively.
%
%	See also TR2RPY, EUL2TR

%	Copright (C) Peter Corke 1993
function r = xyzrpy2tr(v)
r = rotz(v(4)) * roty(v(5)) * rotx(v(6));
r(1,4)=v(1);
r(2,4)=v(2);
r(3,4)=v(3);