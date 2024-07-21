function [] = wv_pund_fet(wavename, amp, period, offset, vd, datasize)
%% waveform & measurement event 
% wavefome of fefet pund pulse
% wavename: Pattern name for RSU1 and RSU2
% eventname: Measure event name for RSU1 and RSU2
% amp, period, offset: waveform properties
% period: period of ONLY one pulse (5 pulses in one PUND waveform)
% datasize: number of measure points in a period (ONLY in one pulse)
    wavename1 = [wavename, num2str(1)];
    wavename2 = [wavename, num2str(2)];
    eventname = ['evt_', wavename];

    WGFMU_MEASURE_EVENT_DATA_AVERAGED = 12000;

%% create the pattern
    % waveform for channel1
    calllib('wgfmu', 'WGFMU_createPattern', wavename1 , offset);
%     calllib('wgfmu', 'WGFMU_addVector', wavename1, period/2,  offset-amp);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period/2,   offset+amp);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period/2,  offset);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period/2,  offset+amp);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period,  offset-amp);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period/2,  offset);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period/2,  offset-amp);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, period/2,  offset);

    % waveform for channel2
    calllib('wgfmu', 'WGFMU_createPattern', wavename2, vd);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, period*4, vd);

%% set measurement event
    if (datasize==0)
        return
    end
    interval = period / datasize; % integrate time of one point
    % measureevent for channel1
    % PUND has 5 period
    datasize = datasize * 4;
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename1, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
    % measureevent for channel2
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename2, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);

end