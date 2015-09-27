%TR2XYZRPY	Convert a homogeneous transform matrix to X, Y, Z positions and roll/pitch/yaw angles
%
%	[X Y Z A B C] = TR2RPY(TR) returns a vector of cartesian positions and Euler angles
%
%	See also  RPY2TR, TR2EUL

function xyzrpy = tr2xyzrpy(m)
	
   xyzrpy = zeros(1,6);
   
   xyzrpy(1)=m(1,4);
   xyzrpy(2)=m(2,4);
   xyzrpy(3)=m(3,4);

	if abs(m(1,1)) < eps & abs(m(2,1)) < eps,
		xyzrpy(4) = 0;
		xyzrpy(5) = atan2(-m(3,1), m(1,1));
		xyzrpy(6) = atan2(-m(2,3), m(2,2));
	else,
		xyzrpy(4) = atan2(m(2,1), m(1,1));
		sp = sin(xyzrpy(4));
		cp = cos(xyzrpy(4));
		xyzrpy(5) = atan2(-m(3,1), cp * m(1,1) + sp * m(2,1));
		xyzrpy(6) = atan2(sp * m(1,3) - cp * m(2,3), cp*m(2,2) - sp*m(1,2));
	end
