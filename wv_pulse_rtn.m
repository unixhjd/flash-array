function [] = wv_pulse_rtn(wavename, vg, vd, hold, period, interval)
%% waveform & measurement event 
% wavefome of RTN pulse
% wavename: Pattern name for RSU1 and RSU2
% eventname: Measure event name for RSU1 and RSU2
% amp, period, offset: waveform properties
% datasize: number of measure points in a period
    wavename1 = [wavename, num2str(1)];
    wavename2 = [wavename, num2str(2)];
    eventname = ['evt_', wavename];

    WGFMU_MEASURE_EVENT_DATA_AVERAGED = 12000;

%% create the pattern
    % waveform for channel1
    calllib('wgfmu', 'WGFMU_createPattern', wavename1 , vg);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, hold,  vg);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period,  vg);
    % waveform for channel2
    calllib('wgfmu', 'WGFMU_createPattern', wavename2, vd);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, hold, vd);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, period, vd);

%% set measurement event
    datasize = period / interval; % integrate time of one point
    display(datasize);
    % measureevent for channel1
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename1, eventname, hold, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
    % measureevent for channel2
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename2, eventname, hold, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);

end