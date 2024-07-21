%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  B1500A intrument control - testtable template - DC idvg
%  Unixjd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% instrument config
% open channel for B1500A semiconductor device analyser
SDA = visadev("GPIB0::18::INSTR");
flush(SDA);
% load library and define parameter
addpath(genpath('./waveforms'));


%% test config
% WGFMU pulse config
current_range = 'WGFMU_MEASURE_CURRENT_RANGE_10MA';
% B1500 SMU config
gate1   = '2'; % gate SMU1
gate2   = '4'; % gate SMU2
drain   = '5'; % drain SMU3, source GNDU
holdtime = 0; delaytime = 0; s_delay = 0;
nop1 = 101;
igatecomp = 0.001;

%% test parameter
vg1_1 = -3; 
vg1_2 =  3;
vd    = 0.1;
vprg  = 5;
vers  = -5;
twrite= 1e-4;

dat = datestr(now,'hhMMSS');

% test data savefile
measure_filePRG = ['./data/DCidvg1', '_vd', num2str(vd), dat, '.csv'];


%% test perform
% B1500 read prg
[Ig, Id] = SMU_idvg_doublesweep(SDA, gate1, drain, holdtime, delaytime, s_delay, ...
    vg1_1, vg1_2, vd, nop1, igatecomp);

% shut instrument
clear SDA;
unloadlibrary('wgfmu');


%% data analysis
vglin = [linspace(vg1, vg2, nop1),linspace(vg2, vg1, nop1)];


%% data save
writematrix([vglin', Id', Ig'], measure_file);
