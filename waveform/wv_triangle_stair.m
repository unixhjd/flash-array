function [] = wv_triangle(wavename, amp, period, offset, vstair, tstair, datasize)
%% waveform & measurement event 
% waveform of trianglewave
% wavename: Pattern name for RSU1 and RSU2
% eventname: Measure event name for RSU1 and RSU2
% amp, period, offset: waveform properties
% vstair: volatge of the planty stair
% tstair: time delay of the staircase
% datasize: number of measure points in a period
    wavename1 = [wavename, num2str(1)];
    wavename2 = [wavename, num2str(2)];
    eventname = ['evt_', wavename];

    WGFMU_MEASURE_EVENT_DATA_AVERAGED = 12000;

%% create the pattern
    % waveform for channel1
    calllib('wgfmu', 'WGFMU_createPattern', wavename1 , offset);
    calllib('wgfmu', 'WGFMU_addVector', wavename1, (period/4)*(vstair/amp),  (vstair+offset));
    % add planty stair voltage
    calllib('wgfmu', 'WGFMU_addVector', wavename1, tstair,  (vstair+offset));
    calllib('wgfmu', 'WGFMU_addVector', wavename1, (period/4)*(1-vstair/amp),  (amp+offset));

    % add top stair 
    calllib('wgfmu', 'WGFMU_addVector', wavename1, tstair,  (amp+offset));

    % downstair
    calllib('wgfmu', 'WGFMU_addVector', wavename1, (period/4)*(1-vstair/amp),  (vstair+offset));
    calllib('wgfmu', 'WGFMU_addVector', wavename1, tstair,  (vstair+offset));
    
    % negative
    calllib('wgfmu', 'WGFMU_addVector', wavename1, (period/2)*(vstair/amp),  (-vstair+offset));
    calllib('wgfmu', 'WGFMU_addVector', wavename1, tstair,  (-vstair+offset));
    calllib('wgfmu', 'WGFMU_addVector', wavename1, (period/4)*(1-vstair/amp),  (-amp+offset));
    calllib('wgfmu', 'WGFMU_addVector', wavename1, tstair,  (-amp+offset));
    calllib('wgfmu', 'WGFMU_addVector', wavename1, (period/4)*(1-vstair/amp),  (-vstair+offset));
    calllib('wgfmu', 'WGFMU_addVector', wavename1, tstair,  (-vstair+offset));
    
    calllib('wgfmu', 'WGFMU_addVector', wavename1, (period/4)*(vstair/amp),  offset);
    % waveform for channel2
    calllib('wgfmu', 'WGFMU_createPattern', wavename2, 0);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, period+6*tstair, 0);

%% set measurement event
    if (datasize==0)
        return
    end
    interval = (period+6*tstair) / datasize; % integrate time of one point
    % measureevent for channel1
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename1, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
    % measureevent for channel2
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename2, eventname, 0, datasize, interval, interval, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
end
