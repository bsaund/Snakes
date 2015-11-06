function generateErrorPoints()
[s, e] = ErrorEstimation.makeSnakes();
n = s.numLinks;

numPoints = 100;
inputAngles = rand(numPoints,n)*180 - 90;
posError = zeros(numPoints, 6);
Jacobians = zeros(n, 6, numPoints);
for i = 1:numPoints
    s.setAngles(inputAngles(i,:));
    e.setAngles(inputAngles(i,:));
    posError(i,:) = e.fkp - s.fkp;
    Jacobians(:,:,i) = s.jacobian();
end




save([fileparts(mfilename('fullpath')) '/error'], 'posError','inputAngles', 'Jacobians')
close all
end