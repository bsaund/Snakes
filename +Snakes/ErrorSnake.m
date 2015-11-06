classdef ErrorSnake < Snakes.GenericSnake
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    %                                               _____                       
    %                       ____                   //---\\                           
    %                    _ /    /\                ||     ||                     
    %                  /   \___|  |                     //                           
    %      ____  ____ /   /    |  |                    //                           
    %     |    \/    \|__/      \/_                   ||                            
    %     |____/\____/           |  \                 ||                               
    %                            \   \ ____                                      
    %                             \__|/   /\          {}                           
    %                                 \___\/                                     
    %                                                                      

    
    properties
    end
    
    methods
        function obj = ErrorSnake(numLinks)
            links = {};
            for i = 1:numLinks
                links{i} = Links.GaussianConstantRandomLink();
            end
            obj@Snakes.GenericSnake(links);
        end
        
        function offset = getOffset(this)
            offset = cellfun(@(x) x.offset, this.links);
        end
        
        function setOffsets(this, offsets)
            for i=1:length(this.links)
                this.links{i}.setOffset(offsets(i));
            end
        end
        
        function setScalings(this, scalings)
            for i=1:length(this.links)
                this.links{i}.setScaling(scalings(i));
            end
        end
        
        function setTransformOffsets(this, offsets)
            for i=1:length(this.links)
                this.links{i}.setTransformOffset(offsets(i,:));
            end
        end
    end
    
end

