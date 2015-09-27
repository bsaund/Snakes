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
    end
    
end

