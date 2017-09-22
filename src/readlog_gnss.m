function dev = readlog_gnss(path, type, trim)  % VALID #1

M = csvread(path);

if nargin == 3
    M = M(round(1 + (size(M, 1) - 1) * trim(1)) : round(1 + (size(M, 1) - 1) * trim(2)), :);
end

switch type
    case 'navicore-bd982'
        dev.t_utc_hour = M(:, 1);  % UTC hour   of day [hours]
        dev.t_utc_min  = M(:, 2);  % UTC minute of day [minutes]
        dev.t_utc_sec  = M(:, 3);  % UTC second of day [seconds]
        
        dev.lat = M(:, 4);  % latitude [deg]
        dev.lon = M(:, 5);  % longitude [deg]
        dev.hgt = M(:, 6);  % height (ellipsoidal) [m]
        
        dev.yaw      = deg2rad(M(:, 7));  % yaw angle  [rad]
        dev.tilt     = deg2rad(M(:, 8));  % tilt angle [rad]
        dev.range_iv = M(:, 9);           % length of internal vector (baseline) [m]
        
        dev.rmse_e  = M(:, 10);  % rms error of east  (longitude) [m]
        dev.rmse_n  = M(:, 11);  % rms error of north (latitude)  [m]
        dev.rmse_u  = M(:, 12);  % rms error of up    (height)    [m]
        
        dev.e = M(:, 13);  % east  component of external vector (ENU) [m]
        dev.n = M(:, 14);  % north component of external vector (ENU) [m]
        dev.u = M(:, 15);  % up    component of external vector (ENU) [m]
        
        dev.soltype_pos = M(:, 16);  % solution type of position (0..not-valid, 1..autonomous, 2..dgnss, 4..rtk-fixed, 5..rtk-float)
        dev.soltype_ori = M(:, 17);  % solution type of orientation (0..not-valid, 1..autonomous, 2..rtk-float, 3..rtk-fixed, 4..dgnss)
end

end
