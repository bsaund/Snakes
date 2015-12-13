addpath ..
addpath ../Tools/Kinematics
hebi_load
HebiApi.clearGroups%     cmd.torque = cmd.torque + eeWeightTorque + eeXHoldingTorque + ...
%         eeYHoldingTorque;
%     cmd.torque = cmd.torque + eePHoldingTorque;% + eeYawHoldingTorque;

g = HebiApi.newConnectedGroupFromName('SEA-Snake','SA013');
g.setFeedbackFrequencyHz(20);
pause(.5)
% HebiApi.
kin = Hebi.getKinematics(g.getNumModules);
% Hebi.gainSettings()
% wv = Hebi.calcWrenchVec(g.getFeedback, kin);

cmd = CommandStruct()

% cmd.position = z;
% g.startLog
while true
    fbk = g.getFeedback;
    pos = fbk.position;
%     eeFrame = kin.getFrames(fbk, 'Output');
%     eeFrame = eeFrame(:,:,8);
%     eepos = tr2xyzrpy(eeFrame);
    
%     cmd.torque = Hebi.getGravCompTorque(kin, fbk.position, wv);
    cmd.torque = kin.getGravCompTorques(pos, ...
        [fbk.accel_x(1), fbk.accel_y(1), fbk.accel_z(1)]);
    g.set(cmd);
    g.getFeedbackFull.pwm_cmd;
%     disp(eepos)
    
end

cmd.torque = z;
g.set(cmd);