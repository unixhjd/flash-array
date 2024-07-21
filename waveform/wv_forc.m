function [] = wv_forc(wavename, amp, k, interval, forc_num)
%% waveform & measurement event 
% waveform of FORC measurement
% wavename: Pattern name for RSU1 and RSU2
% eventname: Measure event name for RSU1 and RSU2
% amp, period, offset: waveform properties
% datasize: number of measure points in a period
    wavename1 = [wavename, num2str(1)];
    wavename2 = [wavename, num2str(2)];
    eventname = ['evt_', wavename];

    WGFMU_MEASURE_EVENT_DATA_AVERAGED = 12000;

    forc_time = 0;

%% create the pattern
    % waveform for channel1
    %---------------------------------------------------------------%
    calllib('wgfmu', 'WGFMU_createPattern', wavename1, 0);
    % forward bias
    calllib('wgfmu', 'WGFMU_addVector', wavename1, amp/k,  amp);
    forc_time = forc_time + amp/k;
    % begin backward sweep
    for i=1:forc_num
        vforc = amp - 2 * amp * i / forc_num;
        calllib('wgfmu', 'WGFMU_addVector', wavename1, (amp-vforc)/k, vforc);
        calllib('wgfmu', 'WGFMU_addVector', wavename1, (amp-vforc)/k,  amp);
        forc_time = forc_time + 2*(amp-vforc)/k;
    end
    calllib('wgfmu', 'WGFMU_addVector', wavename1, amp/k,  0);
    forc_time = forc_time + (amp)/k;
    %---------------------------------------------------------------%
    % waveform for channel2
    calllib('wgfmu', 'WGFMU_createPattern', wavename2, 0);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, forc_time, 0);

%% set measurement event
    % measureevent for channel1
    datasize = forc_time/interval;
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename1, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
    % measureevent for channel2
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename2, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);

end
