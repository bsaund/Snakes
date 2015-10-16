classdef GripperSnake < Snakes.GenericSnake
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    %                                                                      
    %                       ____                                               
    %                    _ /    /\                                          
    %                  /   \___|  |                                                 
    %      ____  ____ /   /    |  |                                                
    %     |    \/    \|__/      \/_                                                
    %     |____/\____/           |  \                                                 
    %                            \   \ ____                                      
    %                             \__|/   /\                                     
    %                                 \___\/                                     
    %                                                                      
    
    properties
    end
    
    methods
        function obj = GripperSnake(numLinks)
            links = {};
            for i = 1:numLinks-1
                links{i} = Links.DummySnakeLink();
            end
            links{numLinks} = Links.GripperLink();
            obj@Snakes.GenericSnake(links);
        end
    end
    
end

