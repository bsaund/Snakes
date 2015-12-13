addpath ..
addpath ../Tools/Kinematics
hebi_load
HebiApi.clearGroups%     cmd.torque = cmd.torque + eeWeightTorque + eeXHoldingTorque + ...
%         eeYHoldingTorque;
%     cmd.torque = cmd.torque + eePHoldingTorque;% + eeYawHoldingTorque;

g = HebiApi.newConnectedGroupFromName('SEA-Snake','SA013');

pause(.1);

g.setFeedbackFrequencyHz(.1);

cmd = CommandStruct();

cmd.torque = -4;

g.set(cmd)

g.startLogFull()

tic
t = toc
prev = t;
while(true)
    t = toc;
    if(t - prev > 1/(.1))
        fbk = g.getFeedbackFull();
        disp(g.getFeedbackFull().deflection)
%         disp(fbk.position)
        prev = t;
    end
end
