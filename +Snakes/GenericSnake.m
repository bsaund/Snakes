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
        
        function T = fk(this)
            T = eye(4);
            for link = this.links
                T = T*link{1}.fk();
            end
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
            angles = [];
            for i=1:length(this.links)
                angles = [angles, this.links{i}.theta];
            end
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
        
        function collision = checkCollisionsDetailed(this)
            v = this.generateVertices()';
            numvert = size(v,1);
            for i=5:numvert
                p1=v(i,:);
                p2=v(i-1,:);
                
                for j=2:(i-3)
                    p3=v(j,:);
                    p4=v(j-1,:);
                    if(distBetweenLineSegments(p1,p2,p3,p4) < 1)
                        collision = true;
                        return
                    end
                end
            end
            collision = false;
        end
        
        function collision = checkCollisions(this)
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
        
    end

    
end

