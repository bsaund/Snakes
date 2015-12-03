classdef GaussianConstantRandomLink < Links.GenericLink
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
%                      _____          _____                                     
%                     |     |        /.---.\                                 
%                     |     |        ||    ||                                
%                      \   /              //                               
%                        O __            //                                 
%                        |   \          ||                                  
%                        l    \         ||                                  
%                         \ . `                                            
%                                       {}                                
    
    properties
        offset
        scaling
        transformOffset
    end
    
    methods
        function obj = GaussianConstantRandomLink()
            T_before = xyzrpy2tr([1,0,0,0,0,0]);
            T_after = xyzrpy2tr([1,0,0,0,0,pi/2]);
            obj@Links.GenericLink(T_before, T_after,@(x) x);
            
            obj.offset = randn()*2;
            obj.scaling = 1;
            obj.transformOffset = 0;
   
            obj.setTransform();
            
            obj.setAngle(0);
        end
        
        function setOffset(this, offset)
            this.offset = offset;
            this.setTransform();
        end
        
        function setScaling(this, scaling)
            this.scaling = scaling;
            this.setTransform();
        end
        
        function setTransformOffset(this, offset)
            this.transformOffset = offset;
            this.setTransform();
        end

        function setTransform(this)
            xi = this.transformOffset;
            this.transformationFromJointMotion = @(theta) xyzrpy2tr([
                0,...%x
                0,...%y
                0,...%z
                this.scaling*theta + this.offset*pi/180,...%r
                0,...%p
                0,...%y
                ] + xi);
        end
    end
    
end

