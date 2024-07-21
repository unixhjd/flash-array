%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  B1500A intrument control - perform test
%  Unixjd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = perform_test(current_range)

    CH1 = 101;
    CH2 = 102;
    
    WGFMU_OPERATION_MODE_DC           = 2000;
    WGFMU_OPERATION_MODE_FASTIV       = 2001;
    WGFMU_OPERATION_MODE_PG           = 2002;
    WGFMU_OPERATION_MODE_SMU          = 2003;
    
    WGFMU_FORCE_VOLTAGE_RANGE_AUTO    = 3000;
    WGFMU_FORCE_VOLTAGE_RANGE_3V      = 3001;
    WGFMU_FORCE_VOLTAGE_RANGE_5V      = 3002;
    WGFMU_FORCE_VOLTAGE_RANGE_10V_NEGATIVE = 3003;
    WGFMU_FORCE_VOLTAGE_RANGE_10V_POSITIVE = 3004;

    

    WGFMU_MEASURE_MODE_VOLTAGE        = 4000;
    WGFMU_MEASURE_MODE_CURRENT        = 4001;

    WGFMU_MEASURE_VOLTAGE_RANGE_5V    = 5001;
    WGFMU_MEASURE_VOLTAGE_RANGE_10V   = 5002;
    
    WGFMU_MEASURE_CURRENT_RANGE_1UA   = 6001;
    WGFMU_MEASURE_CURRENT_RANGE_10UA  = 6002;
    WGFMU_MEASURE_CURRENT_RANGE_100UA = 6003;
    WGFMU_MEASURE_CURRENT_RANGE_1MA   = 6004;
    WGFMU_MEASURE_CURRENT_RANGE_10MA  = 6005;

    WGFMU_MEASURE_ENABLED_DISABLE     = 7000;
    WGFMU_MEASURE_ENABLED_ENABLE      = 7001;

    WGFMU_TRIGGER_OUT_MODE_DISABLE         = 8000;
    WGFMU_TRIGGER_OUT_MODE_START_EXECUTION = 8001;
    WGFMU_TRIGGER_OUT_MODE_START_SEQUENCE  = 8002;
    WGFMU_TRIGGER_OUT_MODE_START_PATTERN   = 8003;
    WGFMU_TRIGGER_OUT_MODE_EVENT           = 8004;
    WGFMU_TRIGGER_OUT_POLARITY_POSITIVE    = 8100;
    WGFMU_TRIGGER_OUT_POLARITY_NEGATIVE    = 8101;

    WGFMU_AXIS_TIME     = 9000;
    WGFMU_AXIS_VOLTAGE  = 9001;

    WGFMU_MEASURE_EVENT_NOT_COMPLETED = 11000;
    WGFMU_MEASURE_EVENT_COMPLETED     = 11001;
    
    WGFMU_MEASURE_EVENT_DATA_AVERAGED = 12000;
    WGFMU_MEASURE_EVENT_DATA_RAW      = 12001;

    % opensession
    calllib('wgfmu', 'WGFMU_openSession', 'GPIB0::18::INSTR');
    calllib('wgfmu', 'WGFMU_initialize');
    
    % current range check
    if (strcmp(current_range,'WGFMU_MEASURE_CURRENT_RANGE_1UA'))
        current_range = 6001;
    elseif (strcmp(current_range,'WGFMU_MEASURE_CURRENT_RANGE_10UA'))
        current_range = 6002;
    elseif (strcmp(current_range,'WGFMU_MEASURE_CURRENT_RANGE_100UA'))
        current_range = 6003;
    elseif (strcmp(current_range,'WGFMU_MEASURE_CURRENT_RANGE_1MA'))
        current_range = 6004;
    elseif (strcmp(current_range,'WGFMU_MEASURE_CURRENT_RANGE_10MA'))
        current_range = 6005;
    else 
        display('current range error');
    end

    % operation mode
    calllib('wgfmu', 'WGFMU_setOperationMode', CH1, WGFMU_OPERATION_MODE_FASTIV);
    calllib('wgfmu', 'WGFMU_setOperationMode', CH2, WGFMU_OPERATION_MODE_FASTIV);
    calllib('wgfmu', 'WGFMU_setMeasureMode', CH1, WGFMU_MEASURE_MODE_VOLTAGE);
    calllib('wgfmu', 'WGFMU_setMeasureMode', CH2, WGFMU_MEASURE_MODE_CURRENT);
    calllib('wgfmu', 'WGFMU_setMeasureCurrentRange', CH2, current_range);

    calllib('wgfmu', 'WGFMU_setTriggerOutMode', CH1, WGFMU_TRIGGER_OUT_MODE_START_SEQUENCE, WGFMU_TRIGGER_OUT_POLARITY_POSITIVE);
    % execute
    calllib('wgfmu', 'WGFMU_connect', CH1);
    calllib('wgfmu', 'WGFMU_connect', CH2);
    calllib('wgfmu', 'WGFMU_execute');
    calllib('wgfmu', 'WGFMU_waitUntilCompleted');
end