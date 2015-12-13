function gravWrenchVec = calcWrenchVec(fbk, kin)

gravity_g = [fbk.accel_x(1); fbk.accel_y(1); fbk.accel_z(1)];
gravity = 9.81 * gravity_g / norm(gravity_g);
masses = kin.getMasses();
gravWrenchVec = zeros(6 * length(masses), 1);
for i=1:length(masses);
    index = (1:3) + 6 * (i-1);
    gravWrenchVec(index) = gravity * masses(i); % N
end

end