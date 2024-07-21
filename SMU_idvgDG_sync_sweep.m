function [Ig1, Ig2, Id] = SMU_idvgDG_sync_sweep(SDA, gate1, gate2, drain, holdtime, delaytime, s_delay, ...
    vg1_1, vg1_2, vd, nop1, igatecomp)

    %% send sweep command lines
    SDA.writeline(['CN ', gate1, ',', gate2, ',', drain]);
    SDA.writeline('FMT 1,1');
    SDA.writeline('TSC 1');
    SDA.writeline('FL 0');
    SDA.writeline('AV 10,1');
    SDA.writeline(['MM 16,', gate1, ',', gate2, ',', drain]);
    SDA.writeline(['CMM', gate1, ',1']);
    SDA.writeline(['CMM', gate2, ',1']);
    SDA.writeline(['CMM', drain, ',1']);
    SDA.writeline(['RI', gate1, ',0']); % auto 1mA range
    SDA.writeline(['RI', gate2, ',0']); % auto 1mA range
    SDA.writeline(['RI', drain, ',0']); % auto 1mA range
    SDA.writeline(['WT', num2str(holdtime), ',', num2str(delaytime), ',', num2str(s_delay)]); % fixed 100mA range
    SDA.writeline('WM 2,1'); % stops abnormal

    %% forwardsweep
    SDA.writeline(['WV', gate1, ',1,0,', num2str(vg1_1), ',', num2str(vg1_2), ',', num2str(nop1), ',', num2str(igatecomp)]); 
    SDA.writeline(['WSV', gate2, '0,', num2str(vg1_1), ',', num2str(vg1_2),  ',', num2str(igatecomp)]); 
    SDA.writeline(['DV', drain, ',0,', num2str(vd), ',',num2str(igatecomp)]);
    SDA.writeline('TSR');
    SDA.writeline('XE');
    writeread(SDA, '*OPC?');
    % read data
    writeread(SDA, 'ERR? 1');
    writeread(SDA, 'NUB?');
    data = read(SDA, 16*7*nop1+1,'char');
    
    %% shut down
    SDA.writeline(['CL ', gate1, ',', gate2, ',', drain]);
    
    %% data process
    Ig1 = [];
    Ig2 = [];
    Id = [];
    for i=1:nop1
        Ig1(i) = str2num(data(1, 20+16*7*(i-1):31+16*7*(i-1)));
        Ig2(i) = str2num(data(1, 52+16*7*(i-1):63+16*7*(i-1)));
        Id(i)  = str2num(data(1, 84+16*7*(i-1):95+16*7*(i-1)));
    end
   
end
