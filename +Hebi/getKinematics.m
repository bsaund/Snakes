function kin = getKinematics(numLinks)
hebi_load

kin = FieldableKinematics();

for i = 1:numLinks
    kin.addModule('ElbowJoint');
end


end