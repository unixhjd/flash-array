function [] = wv_pulse_base(wavename, base, amp, period, rise_fall_time, datasize)
%% waveform & measurement event 
% wavefome of unipolar pulse
% wavename: Pattern name for RSU1 and RSU2
% eventname: Measure event name for RSU1 and RSU2
% amp, period, offset: waveform properties
% datasize: number of measure points in a period
    wavename1 = [wavename, num2str(1)];
    wavename2 = [wavename, num2str(2)];
    eventname = ['evt_', wavename];
    stage_time = period - rise_fall_time*2;

    WGFMU_MEASURE_EVENT_DATA_AVERAGED = 12000;

%% create the pattern
    % waveform for channel1
    calllib('wgfmu', 'WGFMU_createPattern', wavename1 , base);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, rise_fall_time,  amp);
    if (stage_time > 0)
        calllib('wgfmu', 'WGFMU_addVector', wavename1, stage_time, amp);
    end
    calllib('wgfmu', 'WGFMU_addVector', wavename1, rise_fall_time,  base);
    % waveform for channel2
    calllib('wgfmu', 'WGFMU_createPattern', wavename2, 0);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, period, 0);

%% set measurement event
    if (datasize==0)
        return
    end
    interval = period / datasize; % integrate time of one point
    % measureevent for channel1
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename1, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
    % measureevent for channel2
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename2, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);

end