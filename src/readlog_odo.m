function dev = readlog_odo(path, trim)

M = dlmread(path, ' ', 0, 1);

if nargin == 2
    M = M(1 + fix(size(M, 1) * trim(1)):fix(size(M, 1) * trim(2)), :);
end

dev.enc0 = M(:, 1);  % count on encoder #0 [inc]
dev.enc1 = M(:, 2);  % count on encoder #1 [inc]

dev.t_utc_year  = M(:, 3);  % UTC year  [year]
dev.t_utc_month = M(:, 4);  % UTC month [month]
dev.t_utc_day   = M(:, 5);  % UTC day   [day]

dev.t_utc_hour  = M(:, 6);  % UTC hour of day   [hour]
dev.t_utc_min   = M(:, 7);  % UTC minute of day [minute]
dev.t_utc_sec   = M(:, 8);  % UTC second of day [second]
dev.t_utc_msec  = M(:, 9);  % UTC msec of day   [milisecond]

end
