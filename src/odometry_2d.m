function com = odometry_2d(com, init)

E0 = init(1);
N0 = init(2);
A0 = init(3);

% TODO: correction ds -> dd
com.dd = com.ds;  % [m]

com.a_uw  = cumsum(com.da) + A0;  % [deg]

com.a     = mod(com.a_uw, 2*pi);   % [deg]
com.s     = cumsum(com.ds);       % [m]
com.s_abs = cumsum(abs(com.ds));  % [m]

com.de = com.dd .* sin(com.a - com.da / 2);  % [m]
com.dn = com.dd .* cos(com.a - com.da / 2);  % [m]

com.e = cumsum(com.de) + E0;
com.n = cumsum(com.dn) + N0;

end
