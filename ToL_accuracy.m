%%
close all;clc
load('CleanError.mat');

%%
range = ztbestestimate; % m
vel = 2.*ones(size(range)); % m/s
drange = totalErrorT; % m/s
dvel = interp1(RV,ErrorV,range); % m

%%
for i = 1:length(range)
  [ToL(i),dToL(i)] = TimeOfLaunch(range(i),vel(i),drange(i),dvel(i));
end

%%
figure
hold on
grid on
grid minor
plot(range,ToL)
xlabel('Range (m)')
ylabel('ToL (s)')
hold off

%%
figure
hold on
grid on
grid minor
loglog(range,dToL)
ylim([0 10])
xlabel('Range (m)')
ylabel('Error in Time of Launch (s)')
hold off