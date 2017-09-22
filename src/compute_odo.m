function com = compute_odo(uni, params, init)

com = kin_2wheel(uni, params);
com = odometry_2d(com, init);

end
