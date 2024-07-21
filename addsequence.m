%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  B1500A intrument control - add waveform sequence
%  Unixjd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = addsequence(wavename, num)
CH1 = 101;
CH2 = 102;
%% add the waveform of RSU1&2 to the test sequence
% wavename: Pattern name of waveform RSU1 and RUS2
% num: waveform number to add in sequence
    wavename1 = [wavename, num2str(1)];
    wavename2 = [wavename, num2str(2)];

    calllib('wgfmu', 'WGFMU_addSequence', CH1, wavename1, num); 
    calllib('wgfmu', 'WGFMU_addSequence', CH2, wavename2, num); 

end