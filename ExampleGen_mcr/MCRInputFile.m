%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'RM3.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='off';                     % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 600;                   	% Wave Ramp Time [s]
simu.endTime=4200;                       % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.05; 							% Simulation time-step [s]
simu.reloadH5Data =1;
simu.saveMat = 0;

%% Wave Information 
% % noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC');       % Initialize Wave Class and Specify Type  

% % Regular Waves  
% waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
% waves.H = 2.5;                          % Wave Height [m]
% waves.T = 8;                            % Wave Period [s]

% Regular Waves with CIC
% waves = waveClass('regularCIC');           % Initialize Wave Class and Specify Type                                 
% waves.H = 2.5;                          % Wave Height [m]
% waves.T = 8;                            % Wave Period [s]

% % Irregular Waves using PM Spectrum 
% waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
% waves.H = 2.5;                          % Significant Wave Height [m]
% waves.T = 8;                            % Peak Period [s]
% waves.spectrumType = 'PM';              % Specify Wave Spectrum Type

% % Irregular Waves using JS Spectrum with Equal Energy and Seeded Phase
% waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
% waves.H = 2.5;                          % Significant Wave Height [m]
% waves.T = 8;                            % Peak Period [s]
% waves.spectrumType = 'JS';              % Specify Wave Spectrum Type
% waves.freqDisc = 'EqualEnergy';         % Uses 'EqualEnergy' bins (default) 
% waves.phaseSeed = 1;                    % Phase is seeded so eta is the same

% % Irregular Waves using BS Spectrum with Traditional and State Space 
waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
%waves.H = 2;                          % Significant Wave Height [m]
%waves.T = 9.5;                            % Peak Period [s]
waves.spectrumType = 'PM';              % Specify Wave Spectrum Type
waves.numFreq = 250;
%waves.phaseSeed = 2;                    % Phase is seeded so eta is the same
waves.statisticsDataLoad = 'SETSJPD.xlsx';

% simu.ssCalc = 1;                        % Turn on State Space
% waves.freqDisc = 'Traditional';         % Uses 1000 frequnecies

% Irregular Waves with imported spectrum
%waves = waveClass('spectrumImport');        % Create the Wave Variable and Specify Type
%waves.spectrumDataFile = 'spectrumData.mat';  %Name of User-Defined Spectrum File [:,2] = [f, Sf]

% % Waves with imported wave elevation time-history  
% waves = waveClass('etaImport');         % Create the Wave Variable and Specify Type
% waves.etaDataFile = 'etaData.mat'; % Name of User-Defined Time-Series File [:,2] = [time, eta]

%% Body Data
% Float
body(1) = bodyClass('hydroData/rm3.h5');      
    %Create the body(1) Variable, Set Location of Hydrodynamic Data File 
    %and Body Number Within this File.   
body(1).geometryFile = 'geometry/float.stl';    % Location of Geomtry File
body(1).mass = 'equilibrium';                   
    %Body Mass. The 'equilibrium' Option Sets it to the Displaced Water 
    %Weight.
body(1).momOfInertia = [20907301 21306090.66 37085481.11];  %Moment of Inertia [kg*m^2]     
body(1).viscDrag.cd=[1 0 1.1 0 1.1 0];
body(1).viscDrag.characteristicArea=[20*3 0 pi*10^2 0 pi*10^5 0];

% Spar/Plate
body(2) = bodyClass('hydroData/rm3.h5'); 
body(2).geometryFile = 'geometry/plate.stl'; 
body(2).mass = 'equilibrium';                   
body(2).momOfInertia = ...
    [136973875.5 136973875.5 28542224.82];  % Moment of Inertia [kg-m^2]
body(2).viscDrag.cd=[1 0 3.7 0 3.7 0];
body(2).viscDrag.characteristicArea=[6*27 0 pi*15^2 0 pi*15^5 0];

body(3) = bodyClass('');                            % Initialize bodyClass
body(3).geometryFile = 'geometry/plate.stl'; 
body(3).nhBody          = 1;                    % Turn non-hydro body on
body(3).name            = 'sensor';                 % Specify body name
body(3).mass            = 0.0001;               % Define mass [kg]   
body(3).momOfInertia    = [0.0001 0.0001 0.0001]; % Moment of Inertia [kg*m^2]      
body(3).dispVol         = 0;                    % Specify Displaced Volume  
body(3).cg              = [0 0 -30.0];              % Specify Cg 

%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); % Initialize Constraint Class for Constraint1
constraint(1).loc = [0 0 0];                    % Constraint Location [m]

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).k = 0;                                   % PTO Stiffness [N/m]
pto(1).c = 500000:2000000:12500000;                             % PTO Damping [N/(m/s)]
pto(1).loc = [0 0 0];                           % PTO Location [m]

mooring(1) = mooringClass('mooring');       % Initialize mooringClass
mooring(1).matrix.k = zeros(6,6);
mooring(1).matrix.k(1,1) = 1e5;
mooring(1).matrix.c = zeros(6,6);
mooring(1).matrix.preTension = zeros(1,6);

