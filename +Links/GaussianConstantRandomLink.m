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
    end
    
    methods
        function obj = GaussianConstantRandomLink()
            T_before = xyzrpy2tr([1,0,0,0,0,0]);
            T_after = xyzrpy2tr([1,0,0,0,0,pi/2]);
            obj@Links.GenericLink(T_before, T_after,@(x) x);
            
            obj.offset = randn()*2;
   
            obj.makeTransform();
            
            obj.setAngle(0);
        end
        
        function setOffset(this, offset)
            this.offset = offset;
            this.transformationFromJointMotion = this.makeTransform();
        end
        

        function t = makeTransform(this)
            t = @(theta) xyzrpy2tr([0,0,0,...
                theta + this.offset*pi/180,...
                0,0]);
        end
    end
    
end

