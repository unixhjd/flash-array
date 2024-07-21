function [Ig, Id] = SMU_idvg_doublesweep(SDA, gate, drain, holdtime, delaytime, s_delay, ...
    vg1, vg2, vd, nop1, igatecomp)

    %% send sweep command lines
    SDA.writeline(['CN ', gate, ',', drain]);
    SDA.writeline('FMT 1,1');
    SDA.writeline('TSC 1');
    SDA.writeline('FL 0');
    SDA.writeline('AV 10,1');
    SDA.writeline(['MM 16,', gate, ',', drain]);
    SDA.writeline(['CMM', gate, ',1']);
    SDA.writeline(['CMM', drain, ',1']);
    SDA.writeline(['RI', gate, ',0']); % auto 1mA range
    SDA.writeline(['RI', drain, ',0']); % auto 1mA range
    SDA.writeline(['WT', num2str(holdtime), ',', num2str(delaytime), ',', num2str(s_delay)]); % fixed 100mA range
    SDA.writeline('WM 2,1'); % stops abnormal

    %% forwardsweep
    SDA.writeline(['WV', gate, ',1,0,', num2str(vg1), ',', num2str(vg2), ',', num2str(nop1), ',', num2str(igatecomp)]); 
    SDA.writeline(['DV', drain, ',0,', num2str(vd), ',',num2str(igatecomp)]);
    SDA.writeline('TSR');
    SDA.writeline('XE');
    writeread(SDA, '*OPC?');
    % read data
    writeread(SDA, 'ERR? 1');
    writeread(SDA, 'NUB?');
    dataforward = read(SDA, 16*5*nop1+1,'char');

    %% backward sweep
    SDA.writeline(['WV', gate, ',1,0,', num2str(vg2), ',', num2str(vg1), ',', num2str(nop1), ',', num2str(igatecomp)]); 
    SDA.writeline(['DV', drain, ',0,', num2str(vd), ',',num2str(igatecomp)]);
    SDA.writeline('TSR');
    SDA.writeline('XE');
    writeread(SDA, '*OPC?');
    % read data
    writeread(SDA, 'ERR? 1');
    writeread(SDA, 'NUB?');
    databackward = read(SDA, 16*5*nop1+1,'char');    
    
    %% shut down
    SDA.writeline(['CL ', gate, ',', drain]);
    
    %% data process
    Ig = [];
    Id = [];
    for i=1:nop1
        Ig(i) = str2num(dataforward(1, 20+16*5*(i-1):31+16*5*(i-1)));
        Id(i) = str2num(dataforward(1, 52+16*5*(i-1):63+16*5*(i-1)));
    end
    for i=1:nop1
        Ig(i+nop1) = str2num(databackward(1, 20+16*5*(i-1):31+16*5*(i-1)));
        Id(i+nop1) = str2num(databackward(1, 52+16*5*(i-1):63+16*5*(i-1)));
    end
   
end
