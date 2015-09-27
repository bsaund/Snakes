function H=homogeneousInverse(H)
    R = H(1:3, 1:3)';
    H(1:3,4) = - R*H(1:3,4);
    H(1:3, 1:3) = R;
end