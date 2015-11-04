function SVR()
runData()
end

function runData()
close all
load([fileparts(mfilename('fullpath')) '\error']);
[s,e] = ErrorEstimation.makeSnakes();

C=4;
eps=0.001;
kern = @(xi, xj) xi * xj';

% x=inputAngles;
x = squeeze(Jacobians(:,1,:))';
y = posError(:,1);
n = size(x,1);
k = zeros(n);
for i=1:n
    
    for j=1:n
        k(i,j) = kern(x(i,:), x(j,:));
    end
end

a = computeSVR(k, y(:,1), C, eps);
a = a(1:n);
% b = a(51:100);
% a = a(1:50);
% displayImage(X(1,:));

% save('learnedWeights', 'b','w', 'correct')

f = k'*a;
max(abs(y))
max(abs(f - y))



end



function a=computeSVR(XKern,y, C, eps)
n = size(y,1);
s = ones(size(y));
z = zeros(size(XKern));
f = [-y; eps*s; zeros(2*n,1)];
Aeq = [eye(n), z, -eye(n), eye(n);
    z, eye(n), -eye(n), -eye(n);
    zeros(2*n, 4*n)];
beq = zeros(4*n,1);
H = [XKern, zeros(n, 3*n); zeros(3*n, 4*n)];
lb = [-C*s; 0*s; 0*s; 0*s];
ub = [C*s; 2*C*s; C*s; C*s];

a = quadprog(H, f, [], [], Aeq, beq, lb, ub, [], optimset('Algorithm', ...
    'interior-point-convex'));
end
