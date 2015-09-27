classdef GenericLink < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        T_beforeJoint
        T_joint
        T_afterJoint
        theta
        
        transformationFromJointMotion
    end
    
    methods
        function this = GenericLink(T_beforeJoint, T_afterJoint, ...
                transformationFromJointMotion)
            this.T_beforeJoint = T_beforeJoint;
            this.T_afterJoint = T_afterJoint;
            this.transformationFromJointMotion = transformationFromJointMotion;
        end
        
        function setAngle(this, theta)
            this.theta = theta;
            this.T_joint = this.transformationFromJointMotion(theta * pi/180);
        end
        
        function T=fk(this)
            T= this.T_beforeJoint * this.T_joint * this.T_afterJoint;
        end
        
        function T=bk(this)
            T = homogeneousInverse(this.fk());
        end
    end
    
end

