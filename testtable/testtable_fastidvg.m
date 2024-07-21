%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  B1500A intrument control - testtable template - WGFMU idvg
%  Unixjd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load wgfmu library and define parameter
loadlibrary(wgfmu_dll, wgfmu_matlab_h);
%% add waveform functions path
addpath(genpath('./waveforms'));


vd = 1;
delay = 1e-3;
vw = 3;

tw = 1e-5;
tstep = 1e-3;
current_range = 'WGFMU_MEASURE_CURRENT_RANGE_100UA';


dat =  ['_dt',datestr(now,'hhMMSS')];

measurefile = ['./data/idvg1_vd_', num2str(vd), 'tstep_', num2str(tstep),dat,'.csv'];
calllib('wgfmu', 'WGFMU_clear');

% add waveform here
wv_stair_idvg('read1', vd, tstep, 0, 3, 0.01);
wv_stair_idvg('read2', vd, tstep, -3, 0, 0.01);
wv_spacer('spacer1', delay, 0);

% manage sequence
addsequence('read1', 2);
addsequence('read2', 2);
addsequence('spacer1', 1);


% perform test
perform_test(current_range);
% get and save measure data
getmeasure(measurefile);
% disconnect
disconnect();

pause(0.1);


%% unload library
unloadlibrary('wgfmu');
