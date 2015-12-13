function generateErrorPoints()
[s, e] = ErrorEstimation.makeSnakes();
n = s.numLinks;

numPoints = 400;
inputAngles = rand(numPoints,n)*180 - 90;
posError = zeros(numPoints, 6);
Jacobians = zeros(n, 6, numPoints);
for i = 1:numPoints
    s.setAngles(inputAngles(i,:));
    e.setAngles(inputAngles(i,:));
    posError(i,:) = e.fkp - s.fkp + randn(1,6).*[.04,.04,.04,0,0,0];
    Jacobians(:,:,i) = s.jacobian();
end




save([fileparts(mfilename('fullpath')) '/errorScalingWithNoise'], 'posError','inputAngles', 'Jacobians')
close all
end