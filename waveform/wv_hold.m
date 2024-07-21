function [] = wv_hold(wavename, amp1, amp2, spacer_time, datasize)
%% waveform & measurement event 
% waveform of hold time
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
    calllib('wgfmu', 'WGFMU_createPattern', wavename1 , amp1);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, spacer_time, amp1);
    % waveform for channel2
    calllib('wgfmu', 'WGFMU_createPattern', wavename2, amp2);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, spacer_time, amp2);

%% set measurement event
    if (datasize==0)
        return
    end
    interval = spacer_time / datasize; % integrate time of one point
    % measureevent for channel1
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename1, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
    % measureevent for channel2
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename2, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
end
