% === CONFIG ===
ex_id   = 1;  % #id of experiment
t_range = [0.21, 0.8];  % used time range

% === FILE PATHS ===
pathprefix = '../data/';

path_gnss  = {[pathprefix, 'exp-1-gnss/gnss_2017-04-06_16-01-04.csv']};

path_odo   = {[pathprefix, 'exp-1-gnss/odo_2017-04-06_16-00-16-mod.log']};

% === PROCESSING ===
gnss.name = 'gnss';
gnss.dev  = readlog_gnss(path_gnss{ex_id}, 'navicore-bd982', t_range(ex_id, :));
gnss.uni.t_utc = gnss.dev.t_utc_hour * 3600 + gnss.dev.t_utc_min * 60 + gnss.dev.t_utc_sec;  % [s]

odo.name = 'odo';
odo.params.init  = [1/20000, 1/20000, 0.7];  % chassis params [m/inc, m/inc, m]
odo.params.calib = [0.8200 / 20000, 0.8199 / 20000, 0.565];

odo.dev  = readlog_odo(path_odo{ex_id}, t_range(ex_id, :));

odo.uni.phi0 = -odo.dev.enc1;
odo.uni.phi1 = -odo.dev.enc0;
odo.uni.t_utc = odo.dev.t_utc_hour * 3600 + odo.dev.t_utc_min * 60 + odo.dev.t_utc_sec + odo.dev.t_utc_msec / 1000;

odo.com  = compute_odo(odo.uni, odo.params.calib, [gnss.dev.e(1), gnss.dev.n(1), gnss.dev.yaw(1)]);

% === SYNC ===
[~, indices_gnss, indices_odo] = intersect(uint32(gnss.uni.t_utc*1000), uint32(odo.uni.t_utc*1000));

% === GRAPHING ===

figure(1)
clf

plot(gnss.dev.e, gnss.dev.n, 'g', 'LineWidth', 3)
hold on
plot(odo.com.e, odo.com.n, 'r', 'LineWidth', 2)
