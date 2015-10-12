classdef DummySnake < Snakes.GenericSnake
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
        function obj = DummySnake(numLinks)
            links = {};
            for i = 1:numLinks
                links{i} = Links.DummySnakeLink();
            end
            obj@Snakes.GenericSnake(links);
        end
    end
    
end

