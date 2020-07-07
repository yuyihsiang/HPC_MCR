%Example of user input MATLAB file for post processing

%Plot waves
% waves.plotEta(simu.rampTime);
% try 
%     waves.plotSpectrum();
% catch
% end
% 
% %Plot heave response for body 1
% output.plotResponse(1,3);
% 
% %Plot heave response for body 2
% output.plotResponse(2,3);
% 
% %Plot heave forces for body 1
% output.plotForces(1,3);
% 
% %Plot pitch moments for body 2
% output.plotForces(2,5);
A(:,1)=waves.w./2./pi;
A(:,2)=(waves.A.*waves.dw).^0.5;
A(:,3)=waves.phase./pi.*180;
B(:,1)   = output.bodies(3).time;
B(:,2:7) = output.bodies(3).position(:,1:6);
