
%g is the group of modules
%Gains is a struct of gains = g.getGains()

hebi_load
HebiApi.clearGroups()

% links = {'SA011';'SA013';'SA015';'SA017';'SA018';...
%     'SA025';'SA027';'SA036';'SA043';'SA046';'SA048'};
% 
% g = HebiApi.newGroupFromNames('SEA-Snake',...
%     links);

g = HebiApi.newConnectedGroupFromName('SEA-Snake','SA013');
g.setFeedbackFrequencyHz(20);

% load('ArmGains')
% 
% % 
% % 
% 
% 
% 
% gains.control_strategy(:) = 3;
% gains.position_kp(:) = 5;
% gains.position_ki(:) = .1;
% gains.position_kd(:) = 10;
% 
% gains.velocity_kd(:) = 100;
% gains.torque_ki(:) = .1;




% tic
% t = toc
% 
% while t<1
%     g.set('gains', gains);
%     t = toc;
% end

% gend = HebiApi.newGroupFromNames('SEA-Snake',links(end));
pause(1);
% gains = gend.getGains();
info = g.getInfo();

gains = GainStruct();
          gains.control_strategy= 4;
               gains.position_kp= 8;
               gains.position_ki= 0;
               gains.position_kd= 27;
               gains.position_ff= 0;
        gains.position_dead_zone= 0;
          gains.position_i_clamp= -0;
            gains.position_punch= 0;
       gains.position_min_target= -1.771;
       gains.position_max_target= 1.771;
       gains.position_min_output= -12;
       gains.position_max_output= 12;
 gains.position_target_lowpass_gain= 1;
 gains.position_output_lowpass_gain= 1;
       gains.position_d_on_error= 1;
               gains.velocity_kp= 1;
               gains.velocity_ki= 0;
               gains.velocity_kd= 0;
               gains.velocity_ff= 0.2894;
        gains.velocity_dead_zone= 0.2;
          gains.velocity_i_clamp= 0.3;
            gains.velocity_punch= 0;
       gains.velocity_min_target= -3.456;
       gains.velocity_max_target= 3.456;
       gains.velocity_min_output= -1;
       gains.velocity_max_output= 1;
gains.velocity_target_lowpass_gain= 1;
gains.velocity_output_lowpass_gain= 1;
       gains.velocity_d_on_error= 1;
                 gains.torque_kp= 0.5;
                 gains.torque_ki= 0;
                 gains.torque_kd= 12;
                 gains.torque_ff= 0;
          gains.torque_dead_zone= 0.01;
            gains.torque_i_clamp= -0;
              gains.torque_punch= 0;
         gains.torque_min_target= -12;
         gains.torque_max_target= 12;
         gains.torque_min_output= -1;
         gains.torque_max_output= 1;
gains.torque_target_lowpass_gain= 1;
gains.torque_output_lowpass_gain= 0.25;
         gains.torque_d_on_error= 0;



for ind = 1:info.num_modules
    gtemp = HebiApi.newGroupFromNames(info.family(ind), info.name(ind));
    disp(info.name(ind));
    pause(1.5);
    tic
    t = toc;
    while t < .3;
        gtemp.set('gains',gains);
        gtemp.set('persist', true);
        t = toc;
    end
    
end







