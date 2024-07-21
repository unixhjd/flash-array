function [] = wv_stair_idvg(wavename, vd, ... 
    vg_step_time, vg_start, vg_stop, vg_step_len)
%% waveform & measurement event 
% wavename: Pattern name for RSU1 and RSU2
% eventname: Measure event name for RSU1 and RSU2
% amp, period, offset: waveform properties
% datasize: number of measure points in a period
    wavename1 = [wavename, num2str(1)];
    wavename2 = [wavename, num2str(2)];
    eventname = ['evt_' , wavename];

    WGFMU_MEASURE_EVENT_DATA_AVERAGED = 12000;
    
    %% vg parameter set
    % step_time = rise_time + delay_time + stair_time
    vg_rise_time  = vg_step_time/10;
    vg_delay_time = vg_step_time*6/10;
    vg_stair_time = vg_step_time*3/10;
    % Gate voltage range
    vg_step_num = abs(vg_stop-vg_start)/abs(vg_step_len) + 1;
    % vd parameter set
    vd_rise_time = vg_rise_time;
    vd_step_time = vg_step_time*abs(vg_step_num);
    
%% create pattern
    % waveform for RSU1_gate
    calllib('wgfmu', 'WGFMU_createPattern', wavename1, 0);
    for i=1:vg_step_num
        vgi = vg_start + (i-1)*vg_step_len;
        calllib('wgfmu', 'WGFMU_addVector', wavename1, vg_rise_time, vgi);
        calllib('wgfmu', 'WGFMU_addVector', wavename1, vg_delay_time + vg_stair_time, vgi);
    end
    % waveform for RSU2_drain
    calllib('wgfmu', 'WGFMU_createPattern', wavename2, 0);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, vd_rise_time, vd);
    calllib('wgfmu', 'WGFMU_addVector', wavename2, vd_step_time-vd_rise_time, vd);
%% measurement event set
    % measure event for RSU1-VG & RSU2-ID
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename1, eventname, ...
        vg_rise_time+vg_delay_time, ...
        vg_step_num, vg_step_time, vg_stair_time, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
    calllib('wgfmu', 'WGFMU_setMeasureEvent', wavename2, eventname, ...
        vg_rise_time+vg_delay_time, ...
        vg_step_num, vg_step_time, vg_stair_time, ...
        WGFMU_MEASURE_EVENT_DATA_AVERAGED);
  
end

