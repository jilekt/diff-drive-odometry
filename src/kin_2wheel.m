function com = kin_2wheel(uni, params)

com.dphi0 = [0; uni.phi0(2:end) - uni.phi0(1:end-1)];  % [inc]
com.dphi1 = [0; uni.phi1(2:end) - uni.phi1(1:end-1)];  % [inc]

% TODO: check over-range

C0 = params(1);
C1 = params(2);
TW = params(3);

com.ds0 = com.dphi0 * C0;  % [m]
com.ds1 = com.dphi1 * C1;  % [m]

com.ds = (com.ds0 + com.ds1) / 2;   % [m]
com.da = (com.ds0 - com.ds1) / TW;  % [rad]

end
