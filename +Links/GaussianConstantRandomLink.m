classdef GaussianConstantRandomLink < Links.GenericLink
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
%                      _____          _____                                     
%                     |     |        //---\\                                 
%                     |     |        ||    ||                                
%                      \   /              //                               
%                        O __            //                                 
%                        |   \          ||                                  
%                        l    \         ||                                  
%                         \ . `                                            
%                                       {}                                
    
    properties
        offset
    end
    
    methods
        function obj = GaussianConstantRandomLink()
            offset = randn()*2;
            T_before = xyzrpy2tr([1,0,0,0,0,0]);
            T_after = xyzrpy2tr([1,0,0,0,0,pi/2]);
            joint = @(theta) xyzrpy2tr([0,0,0,theta + offset*pi/180,0,0]);
            
            obj@Links.GenericLink(T_before, T_after, joint);
            obj.offset = offset;
            obj.setAngle(0);
        end
        
        function setOffset(this, offset)
            this.offset = offset;
            this.transformationFromJointMotion = ...
                @(theta) xyzrpy2tr([0,0,0,theta + offset*pi/180,0,0]);
        end
            
    end
    
end

