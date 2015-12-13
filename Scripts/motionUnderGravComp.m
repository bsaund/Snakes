addpath ..
addpath ../Tools/Kinematics
hebi_load
% HebiApi.clearGroups%     cmd.torque = cmd.torque + eeWeightTorque + eeXHoldingTorque + ...
%         eeYHoldingTorque;
%     cmd.torque = cmd.torque + eePHoldingTorque;% + eeYawHoldingTorque;

% g = HebiApi.newConnectedGroupFromName('SEA-Snake','SA013');
g.setFeedbackFrequencyHz(100);
pause(.5)
% HebiApi.
kin = Hebi.getKinematics(g.getNumModules);
% Hebi.gainSettings()
% wv = Hebi.calcWrenchVec(g.getFeedback, kin);

cmd = CommandStruct()

desiredPos = [-50,0,0,0,...
    0,0,0,0] * pi/180;

% cmd.position = z;
% g.startLog


load('EEpath');

% z_desired = 0.4;
% dir = 1;
i = 1;

while true
    fbk = g.getFeedback;
    pos = fbk.position;
%     eeFrame = kin.getFrames(fbk, 'Output');
%     eeFrame = eeFrame(:,:,8);
%     eepos = tr2xyzrpy(eeFrame);
    
%     cmd.torque = Hebi.getGravCompTorque(kin, fbk.position, wv);
    cmd.torque = kin.getGravCompTorques(pos, ...
        [fbk.accel_x(1), fbk.accel_y(1), fbk.accel_z(1)]);
    i = i+1;
    if (i > size(path,1))
        i = 1;
    end
    
    
    
%     if(dir == 1)
%         if(z_desired < 0.4)
%             z_desired = z_desired + 0.01;
%         else
%             dir = -1
%         end
%     else
%         if(z_desired > 0.2)
%             z_desired = z_desired - 0.01;
%         else
%             dir = 1;
%         end
%     end
    pause(.02)
        
    
    cmd.position = kin.getInverseKinematics('xyz',[-.2, path(i,1) ,path(i,2)]);
%     cmd.position = kin.getInverseKinematics('xys',[-.2, 0,z_desired]);
%     cmd.position = desiredPos;
    cmd.velocity = zeros(size(cmd.position));
    g.set(cmd);
    g.getFeedbackFull.pwm_cmd;
    disp((pos - cmd.position)*180/pi)
    
end

cmd.torque = z;
g.set(cmd);