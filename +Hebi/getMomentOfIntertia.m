function MoI = getMomentOfIntertia(g, kin)
hebi_load;

fbk = g.getFeedback();

fr_mass = kin.getFrames(fbk, 'CoM');
fr_joint = kin.getFrames(fbk, 'Output');
m = kin.getMasses();
n = kin.getNumDoF();
% fr_joint(:,:,1)

fr_from = zeros(4,4,n);
MoI = zeros(1,n);


% Add the Moment Of Intertia from each other link
for j = 1:n
    for i = j+1:n
        %The fr_from is the transform from j to i
        fr_from(:,:,i) = inv(fr_mass(:,:,j)) * fr_mass(:,:,i);
        %The links rotate about y, so add mass * |v_projected to XZ|
        MoI(j) = MoI(j) + norm([fr_from(1,4,i), fr_from(3,4,i)]) * m(i);
    end
end




end