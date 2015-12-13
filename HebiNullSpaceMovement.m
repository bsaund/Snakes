

n = 8;

kin = Hebi.getKinematics(n);

% angles = zeros(1,n);
% angles(2) = pi/8;
% angles(4) = pi/4;
% angles(6) = -pi/4;
% angles(8) = pi/4;

angles = [0;
    pi/8;
    0;
    pi/4;
    0;
    -pi/4;
    0;
    pi/4];


frames = kin.getFrames(angles, 'Output');
initialEE = frames(1:3,4,n);

fbk.accel_x = 0; 
fbk.accel_y = 0; 
fbk.accel_z = -1;
wv = Hebi.calcWrenchVec(fbk, kin);


for i = 1:100
    J = kin.getJacobian(angles, 'Output');
    J = J(end-5:end, :);
    ns = null(J);
    
    angles = angles + ns(:,1)*.01;
    
    f = kin.getFrames(angles,'Output');
    f(1:3,4,n)
end



