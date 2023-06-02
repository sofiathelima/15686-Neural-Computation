%% Integration of Hodgkin--Huxley equations with analytical method
  clear; clf;
% plot this solution of Vm on a graph, 
% with y-axis showing Vm in mV, 
% and x-axis showing time in msec 
% (lasting from -50 ms to 200 msec)


x0 = -50;
xlast = 200;

I0 = 0.3;

% t_on = 0;
t_off = 100;

Vrest = -70;
R = 100; %M-Ohm
C = 100; %pF
tau = 10; %msec

Vm = zeros(xlast-x0,1);

for t = x0:xlast
    if t < 0
        Vm(t-x0+1) = Vrest;
    elseif t < t_off
        Vm(t-x0+1) = R*I0*(1-exp(-t/tau)) + Vrest;
    else
        Vm(t-x0+1) = R*I0*exp(-(t-t_off)/tau) + Vrest;
    end
end

fig1 = figure; % Open new figure window
x = x0:xlast; % x-data
plot(x,Vm); % Plot 
hold on; % Allow future plots to be added above the current plot

ylim([-90 -20])

title('HW1 #1d: Membrane dynamics');
xlabel('time (msec)');
ylabel('membrane voltage');
legend('I0 = 0.3 nA');

saveas(fig1,'1d.jpg');
