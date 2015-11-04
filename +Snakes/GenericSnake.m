classdef GenericSnake
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        links
    end
    
    methods
        function obj = GenericSnake(links)
            obj.links = links;
            close all
            figure()   
        end
        
        function T = fk(this, angles)
            if(nargin > 1)
                this.setAngles(angles);
            end
            T = eye(4);
            for link = this.links
                T = T*link{1}.fk();
            end
        end
        
        function P = fkp(this, varargin)
            P = tr2xyzrpy(this.fk(varargin{:}));
        end
        
        function T = bk(this)
            T = homogeneousInverse(this.fk());
        end
        
        function setAngles(this, angles)
            for i=1:length(this.links)
                this.links{i}.setAngle(angles(i));
            end
        end
        
        function angles = getAngles(this)
            angles = cellfun(@(x) x.theta, this.links);
        end
        
        function n = numLinks(this)
            n = size(this.links,2);
        end
        
        function J = jacobian(this)
            angles = this.getAngles();
            pos = this.fkp();
            da = .01;
            J = zeros(this.numLinks,size(pos,2));
            for i= 1:this.numLinks
                t = angles;
                t(i) = t(i) + da;
                this.setAngles(t);
                J(i,:) = (this.fkp() - pos)/da;
            end
            this.setAngles(angles);
        end
        
        function points = generateVertices(this)
            points = [0;0;0;1];
            T = eye(4);
            for i = 1:size(this.links,2)
                link = this.links{i};
                points(:,i+1) = T*link.T_beforeJoint*[0;0;0;1];
                T = T*link.fk();
            end
            points(:,i+2) = T*[0;0;0;1];
        end
        
        function plot(this)
            Plotting.plotSimpleLinkage(this.generateVertices');
        end
        
        function [dist, ceq] = distFromObjects(this, pos)
            distTol = 2;
            if(nargin > 1)
                this.setAngles(pos);
            end
            ceq = [];
            v = this.generateVertices()';
            numvert = size(v,1);
            minDist = inf;
            for i=5:numvert
                p1=v(i,:);
                p2=v(i-1,:);
                
                for j=2:(i-3)
                    p3=v(j,:);
                    p4=v(j-1,:);
                    minDist = min(minDist, ...
                        distBetweenLineSegments(p1,p2,p3,p4));
                    if(minDist < distTol)
                        dist = 1;
                        return
                    end
                    
                end
            end
            dist = -(minDist - distTol);
        end
        
        function collision = checkCollisions(this)
           collision = this.distFromObjects() > 0;
        end
        
        function [collision, ceq] = checkCollisionsQ(this)
            ceq = [];
            v = this.generateVertices()';
            numvert = size(v,1);
            for i=5:numvert
                p1=v(i,:);
                for j=1:(i-4)
                    p2=v(j,:);
                    if(norm(p1-p2) < 1)
                        collision = true;
                        return
                    end
                end
            end
            collision = false;
        end
        
        function angles = ik(this, cartPos)
            if(min(size(cartPos)) ~= 1)
                cartPos = tr2xyzrpy(cartPos);
            end
            ar = cat(1,this.links{:});
            lb = cat(1,ar.lb);
            ub = cat(1,ar.ub);
            

            fun = @(x) tr2xyzrpy(this.fk(x));
            target = @(x) norm(fun(x) - cartPos);
%             target = @(x) max(x);
            angles = fmincon(target, this.getAngles(),[],[],[],[],lb, ub, ...
                @this.distFromObjects);
        end
        
        
    end


end

