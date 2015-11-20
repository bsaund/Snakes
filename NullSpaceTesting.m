close all

HebiApi.clearGroups()

g = HebiApi.newGroupFromNames('SEA-Snake',...
    {'SA048';'SA043';'SA018';'SA010';...
    'SA013';'SA025';'SA015';'SA011';'SA017';'SA046'});
g.setFeedbackFrequencyHz(100);

cmd = CommandStruct();
pos  = zeros(1,10);

pos(2) = pi/8;
pos(4) = pi/4;
pos(6) = -pi/4;
pos(8) = pi/4;
pos(10) = -pi/4;
cmd.position = pos;

g.set(cmd)


s = Snakes.DummySnake(10);
fb = g.getFeedback();
s.setHebiAngles(pos);
fk = s.fk();
disp(num2str(fk(1:3, 4)'))



tic
t = toc
i = 0;
dir = 1;
while t < 100
    if i > 100
        i = 0;
        dir = -dir;
    end
    
    n = null(s.jacobian()')';
    a = s.getAngles();
    a = a + dir*n(1,:);
    s.setAngles(a);
    disp(num2str(fk(1:3,4)'))
    cmd.position = s.getHebiAngles;
    
    g.set(cmd);
    
    %     if(mod(i,10) < 1)
    %         s.plot
    %         pause(.1)
    i = i+1;
    t = toc;
end

























    