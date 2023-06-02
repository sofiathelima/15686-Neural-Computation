I_on = 3.0*10^-10; % injected current in amps
I_on_time = 0.0; % injected current on time in sec
I_off_time = 0.10; % injected current off time in sec
R = 100*10^6; % membrane resistence in ohms
C = 100*10^-12; % membrane capacitence in farads
v_rest = -0.07; % resting voltage in volts
t_start = I_on_time; % start time for numerical integration
t_end = 0.2; % end time for numerical integration
dt = 0.03; % time step for numerical intergration (seconds)

%set up vectors to store results and populate the initial value
vm = [v_rest]; % initial voltage is resting voltage
time = [t_start]; % initial time is t_start

%euler method y_{n+1} = y_n + dt f(t_n,y_n)

for t = 1:floor((t_end-t_start)/dt)
    step_time = t*dt; % calculate current step time
    time = [time step_time]; % store the current time step into our
                             % results array
                             
    if (t-1)*dt >= I_off_time % calculate the previous time step I_o
        I_o = 0; % I_o shoudl be 0 if we are after off time
    else
        I_o = I_on; % else set to I_on
    end
    
    % TODO: determine the next vm using Euler's method here
    % step_vm = 
    f = (I_o - (vm(end)-v_rest)/R)/C;
    step_vm = (dt*f) + vm(end);
    vm = [vm step_vm]; % store result in the arrayend

end

% graph plot
fig = plot(time, vm); % plot graph with values in time as x and vm as y

% Specify the title, x label, and y label of the plots
title('Problem 1 Part E: Membrane potential with injected current (euler method)')
xlabel('Time (seconds)')
ylabel('Membrane potential (volts)')
ylim([-0.08 -0.03]);
saveas(fig, sprintf('1e_dt%s.png', string(dt)))