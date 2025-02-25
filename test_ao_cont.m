%% Write in continous form

function []=testao2()

dq = daq("ni"); %create data acquisition
dq.Rate = 8000; %set the generation scan rate
% adds analog output channels 
addoutput(dq, "Dev1", "ao0", "Voltage");
addoutput(dq, "Dev1", "ao1", "Voltage");

%vectors size
n = dq.Rate;

reps=1; %initialization of reps
%creation of signals
outputSignal1 = 10*sin(linspace(0,2*pi,n/4)');
outputSignal2 = 10*cos(linspace(0,2*pi,n/4)'); 
outputSignal=[outputSignal1 outputSignal2];

dq.ScansRequiredFcn  = @loadmoredata; % assign callback function to the ScansRequiredFcn of the daq to continuosly generate the output data

preload(dq, repmat(outputSignal,2,1))% Before starting a continuous generation, preload outputSignal
start(dq, "Continuous") % to initiate the generation in continuos form
      
noise=randn(n,1); %creates noise 

while true 
  pause (0.1)
end
      % function to write the signal
      function []=loadmoredata(obj,evt)
%         reps=reps+1;
%         noise=randn(n,1);

%             outputSignalNew= min(max(noise,-1),1);% sets signal to be noise betwaeen 1 and -1
%             outputSignalNew=repmat(outputSignalNew,1,2); % creates matrix with 2 outputSignalNew to feed into both channels
%         outputSignalNew= noise;
%         plot(outputSignalNew)
%         drawnow
        outputSignalNew=outputSignal;
        
%         if reps==5
%             outputSignalNew=outputSignal*0.5*reps;
%         end

        write(obj,outputSignalNew)
      end
  
end
