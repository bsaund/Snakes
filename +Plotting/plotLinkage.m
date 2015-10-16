function plotLinkage(snake)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
global transformationDisplay

figure('un','n','nam','Snake','color','w','pos',[.1 .1 .8 .8])
ma = axes('pos',[.15 .15 1 1]);
axis off
view(3)
rotate3d
grid on
hold on
axes('pos',[.01 .91 .45 .05])
text('position',[0.01,.5],'string','x       y       z       r       p       y','fontsize',15,'fontangle','i')
axis off
axes(ma)
axis equal
transformationDisplay=uicontrol('sty','e','un','n','pos',[.01 .5 .225 .4],'backgroundcolor','w','max',2,'ho','l','fonts',10,'fontn','courier');

updateTransformDisplay(snake)
setSliders(snake)
updatePlot(snake)


end


function updateTransformDisplay(snake)
global transformationDisplay
displayText = [];
for link=snake.links
    displayText = strvcat(displayText, num2str(tr2xyzrpyDeg(link{1}.fk()),'%1.1f  '));
end
set(transformationDisplay,'sty','e')
set(transformationDisplay, 'str', displayText)
end

function setSliders(snake)

    function setLinkAngles(varargin)
        angles = snake.getAngles();
        angles(str2num(varargin{1}.Tag)) = varargin{1}.Value;
        snake.setAngles(angles);
        updateTransformDisplay(snake);
        updatePlot(snake);
    end

%Set up axis postion sliders
for k=1:length(snake.links)
    uicontrol('style','slider','tag',num2str(k),'units','norm','pos',[.1 k*.1/2 .1, .05], 'callback',@setLinkAngles,'min',-90,'max',90,'value',snake.links{k}.theta);
    uicontrol('style','text', 'fontsize',14,'fontname','calibri','fontangle','italic','units','norm','backgroundcolor','w','pos',[.2, k*.05 .05 .05], 'string',['\theta', num2str(k)]);
end
end


function updatePlot(snake)
axis on
T = eye(4);
Tnext = snake.links{1}.T_beforeJoint;

P=T(1:3,4);
Pnext = Tnext(1:3,4);

plot3(P(1),P(2),P(3),'k.');
[A,B,C]=cylinder(.5,20);
cyl=surf(A.*.5+P(1),B.*.5+P(2),C.*.5+P(3));
set(cyl,'facecolor',[.4 .8 .4])
rotate(cyl, [0,1,0],90,P);
set(findobj('type','surface'),'facealpha',.5,'edgecolor','k','edgealpha',.25)
axis([-4,4,-4,4,-4,4])

end













