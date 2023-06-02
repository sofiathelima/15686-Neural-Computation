%% Integration of Hodgkin--Huxley equations with Euler method
  clear; clf;
%% Setting parameters
 % Maximal conductances (in units of mS/cm^2); 1=K, 2=Na, 3=R
  g(1)=36; g(2)=120; g(3)=0.3;
 % Battery voltage ( in mV); 1=n, 2=m, 3=h
  E(1)=-12; E(2)=115; E(3)=10.613;
 % Initialization of some variables
  I_ext=0; V=-10; x=zeros(1,3); x(3)=1; t_rec=0;
 % Time step for integration
    dt=0.01;
%% Integration with Euler method   
% note the time unit here is in ms. 
% Note that the resting membrane potential is 0, so the Vm will start at -10 mv 
% and ramp up to 0 mv even without stimulation
  for t=-30:dt:230
     if t==0; I_ext=2; end  % turns external current on at t=0
     if t==200; I_ext=0; end   % turns external current off at t=200
  % alpha functions used by Hodgkin-and Huxley
     Alpha(1)=(10-V)/(100*(exp((10-V)/10)-1));
     Alpha(2)=(25-V)/(10*(exp((25-V)/10)-1));
     Alpha(3)=0.07*exp(-V/20);
  % beta functions used by Hodgkin-and Huxley
     Beta(1)=0.125*exp(-V/80);
     Beta(2)=4*exp(-V/18);
     Beta(3)=1/(exp((30-V)/10)+1);
  % tau_x and x_0 (x=1,2,3) are defined with alpha and beta
     tau=1./(Alpha+Beta);
     x_0=Alpha.*tau;
  % leaky integration with Euler method  -- you can add noise here.
     x=(1-dt./tau).*x+dt./tau.*x_0;
  % calculate actual conductances g with given n, m, h
     gnmh(1)=g(1)*x(1)^4;
     gnmh(2)=g(2)*x(2)^3*x(3);
     gnmh(3)=g(3);
  % Ohm's law
     I=gnmh.*(V-E);
  % update voltage of membrane
     V=V+dt*(I_ext-sum(I));
  % record some variables for plotting after equilibration
     if t>=0;
          t_rec=t_rec+1;
          x_plot(t_rec)=t;
          y_plot(t_rec)=V;
     end
  end  % time loop
%% Plotting results
  plot(x_plot,y_plot); xlabel('Time'); ylabel('Voltage');
