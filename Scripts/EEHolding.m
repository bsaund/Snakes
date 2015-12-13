addpath ..
addpath ../Tools/Kinematics
hebi_load
HebiApi.clearGroups
g = HebiApi.newConnectedGroupFromName('SEA-Snake','SA015');
g.setFeedbackFrequencyHz(20);
pause(.5)
% HebiApi.

eps = .001;

kin = Hebi.getKinematics(g.getNumModules);
% Hebi.gainSettings()
wv = Hebi.calcWrenchVec(g.getFeedback, kin);
zwv = zeros(size(wv));
z_Weight = zwv;
y_Weight = zwv;
x_Weight = zwv;
p_weight = zwv;
yaw_weight = zwv;


z_Weight(end-3) = -5;
% eeWeight(6*3 + 3) = 8;
% y_cmd = .1;
% y_Weight = 
x_cmd = 0;
x_Weight(end-5) = 20;

y_cmd = -.2;
y_Weight(end-4) = 20;

z_cmd = .4;
z_Weight(end-3) = 20;

p_cmd = 0;
p_weight(end-1) = 2;

yaw_cmd = 0;
yaw_weight(end-2) = 2;

z = zeros(1,g.getNumModules);

cmd = CommandStruct()

% cmd.position = z;
tic
while true
    fbk = g.getFeedback;
    pos = fbk.position;
    eeFrame = kin.getFrames(fbk, 'Output');
    eeFrame = eeFrame(:,:,8);
    eepos = tr2xyzrpy(eeFrame);
    
    cmd.torque = Hebi.getGravCompTorque(kin, fbk.position, wv);
    
    
%     eeWeightTorque = Hebi.getGravCompTorque(kin, pos, eeWeight);
    
%     cir_center = [0,.3];
%     cir_r = .03;
%     t = toc;
% %     goal_pos = (eepos(1:2) - cir_center);
% %     goal_pos = cir_r * goal_pos / norm(goal_pos) + cir_center;
%     goal_pos = cir_center + cir_r * [sin(t*pi), cos(t*pi)];
% 
%     x_cmd = goal_pos(1);
%     y_cmd = goal_pos(2);
%     
%     disp([x_cmd, y_cmd])
    
    eeZHoldingTorque = Hebi.getGravCompTorque(kin, pos, z_Weight * (z_cmd - eepos(3)));
    eeXHoldingTorque = Hebi.getGravCompTorque(kin, pos, x_Weight * (x_cmd - eepos(1)));
    eeYHoldingTorque = Hebi.getGravCompTorque(kin, pos, y_Weight * (y_cmd - eepos(2)));
    eePHoldingTorque = Hebi.getGravCompTorque(kin, pos, p_weight * (p_cmd - eepos(5)));
    eeYawHoldingTorque = Hebi.getGravCompTorque(kin, pos, yaw_weight * (yaw_cmd - eepos(6)));
%     cmd.torque = cmd.torque + eeWeightTorque;
    cmd.torque = cmd.torque + eeZHoldingTorque;
    cmd.torque = cmd.torque + eeXHoldingTorque; 
    cmd.torque = cmd.torque + eeYHoldingTorque;
    cmd.torque = cmd.torque + eePHoldingTorque;
    cmd.torque = cmd.torque + eeYawHoldingTorque;
    
    % Compute null space torque to minimize joint angle
%     [sortedAbsPos, sortedInd] = sort(abs(pos), 'descend');
%     scaling = pos(sortedInd(1)) / sortedAbsPos(2);
%     J = kin.getJacobian(fbk, 'Output');
%     J = J(end-5: end, :);
%     nullMovementVec = null(J)';
%     nullMovementCoef = fmincon(...
%         @(alpha) max(abs(pos + alpha' * nullMovementVec)), ...
%         zeros(size(nullMovementVec,1),1), ...
%         ones(1,size(nullMovementVec,1)),...
%         .1)';
%     
%     disp(nullMovementVec)
%     disp((nullMovementCoef * nullMovementVec))
%     nullTorque = nullMovementCoef * nullMovementVec;
%     cmd.torque = cmd.torque + 1 *  nullTorque;
%     disp(nullTorque)
%     disp(pos);
    
%     cmd.velocity = z;
    
%     cmd.position(1:8) = [pi/4, 0,pi/4,pi/4,-pi/4,0, pi/4, 0];
    g.set(cmd);
%     g.getFeedbackFull.pwm_cmd;
%     disp(eepos)
    
end

cmd.torque = z;
g.set(cmd);