%Example of user input MATLAB file for MCR post processing
%filename = ['savedData',sprintf('%03d', imcr),'.mat'];
mcr.Avgpower(imcr) = abs(mean(output.ptos.powerInternalMechanics(1200:end,3)));
mcr.CPTO(imcr)  = pto(1).c;
%filename = sprintf('savedData%03d.mat', imcr);
caseNumST = 1;
wd = 50;
dd = 0 ;
filename = sprintf('../PM_OptCd_All/data/E1_W%d-C%04dD-D%03d_0-H%02d_%02d-T%02d_%01d-S%d.mat', wd, caseNumST-1+imcr, dd, floor(waves.H), (waves.H-floor(waves.H))*100, floor(waves.T), (waves.T-floor(waves.T))*10, waves.phaseSeed);
save (filename, 'mcr');
 
% filename = sprintf('E1_W%d-C%04dC-D%03d_0-H%02d_%02d-T%02d_%01d-S%d.csv', wd, caseNumST-1+imcr, dd, floor(waves.H), (waves.H-floor(waves.H))*100, floor(waves.T), (waves.T-floor(waves.T))*10, waves.phaseSeed);
% csvwrite(filename,A)
 
% filename = sprintf('E1_W%d-C%04dM-D%03d_0-H%02d_%02d-T%02d_%01d-S%d.csv', wd, caseNumST-1+imcr, dd, floor(waves.H), (waves.H-floor(waves.H))*100, floor(waves.T), (waves.T-floor(waves.T))*10, waves.phaseSeed);
% csvwrite(filename,B)
 
% filename = sprintf('E1_W%d-C%04dW-D%03d_0-H%02d_%02d-T%02d_%01d-S%d.csv', wd, caseNumST-1+imcr, dd, floor(waves.H), (waves.H-floor(waves.H))*100, floor(waves.T), (waves.T-floor(waves.T))*10, waves.phaseSeed);
% csvwrite(filename,waves.waveAmpTime);
