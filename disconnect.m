function [] = disconnect()
    CH1 = 101;
    CH2 = 102;
    calllib('wgfmu', 'WGFMU_disconnect', CH1);
    calllib('wgfmu', 'WGFMU_disconnect', CH2);
    calllib('wgfmu', 'WGFMU_initialize');
    calllib('wgfmu', 'WGFMU_closeSession');
end