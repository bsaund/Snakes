classdef GripperLink < Links.GenericLink
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
%                      _____                                               
%                     |     | 
%                     |     | 
%                     |     | 
%                     |     | 
%                     |     | 
%                     |     | 
%                     |     |                                              
%                      \   /                                               
%                        O __                                                 
%                        |   \                                              
%                        l    \                                            
%                         \ . `                                             
%                                                                        
    
    properties
    end
    
    methods
        function obj = GripperLink()
            T_before = xyzrpy2tr([1,0,0,0,0,0]);
            T_after = xyzrpy2tr([7,0,0,0,0,pi/2]);
            joint = @(theta) xyzrpy2tr([0,0,0,theta,0,0]);
            obj@Links.GenericLink(T_before, T_after, joint);
            
            obj.setAngle(0);
        end
    end
    
end

