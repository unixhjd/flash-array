function [Id] = SMU_spot(SDA, gate, drain, holdtime, delaytime, s_delay, ...
    vg, vd, igatecomp)

    %% send sweep command lines
    SDA.writeline(['CN ', gate, ',', drain]);
    SDA.writeline('FMT 1,1');
    SDA.writeline('TSC 1');
    SDA.writeline('FL 0');
    SDA.writeline('AV 1,1');

    SDA.writeline(['DV', gate, ',0,', num2str(vg), ',',num2str(igatecomp)]);
    SDA.writeline(['DV', drain, ',0,', num2str(vd), ',',num2str(igatecomp)]);

    SDA.writeline(['MM 1,', drain]);
    SDA.writeline(['CMM', drain, ',1']);
    SDA.writeline(['RI', drain, ',0']); % auto 1mA range
    SDA.writeline(['WT', num2str(holdtime), ',', num2str(delaytime), ',', num2str(s_delay)]); % fixed 100mA range
    SDA.writeline('WM 2,1'); % stops abnormal

    %% get
    
    SDA.writeline('TSR');
    SDA.writeline('XE');
    writeread(SDA, '*OPC?');
    % read data
    writeread(SDA, 'ERR? 1');
    writeread(SDA, 'NUB?');
    data = read(SDA, 16*3+1,'char');
    
    %% shut down
    SDA.writeline(['CL ', gate, ',', drain]);
    
    %% data process
    Id = str2num(data(1, 20:31));
   
end
