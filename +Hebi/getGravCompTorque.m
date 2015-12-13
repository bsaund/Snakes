function gravCompTorque = getGravCompTorque(kin, angles, gravWrenchVec)

J = kin.getJacobian(angles, 'CoM');
gravCompTorque = (J' * gravWrenchVec)';


end

