classdef GenericSnake
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        links
    end
    
    methods
        function obj = GenericSnake(links)
            obj.links = links;
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
        
        function plot(this)
            Plotting.plotLinkage(this);
        end
    end
    
end

