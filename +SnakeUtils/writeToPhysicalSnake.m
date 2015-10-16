function writeToPhysicalSnake(s)
import org.biorobotics.matlab.*;
import org.biorobotics.matlab.LcmBridge;

angles = s.getAngles*pi/180;

angles = flip(angles);

angleFlips = [1,1,-1,-1,1,1,-1,-1];
angles = angles .* angleFlips;

LcmBridge.setAngles(angles);


end

