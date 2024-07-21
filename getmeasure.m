%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  B1500A intrument control - get measure data
%  Unixjd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = getmeasure(measure_file)
CH1 = 101;
CH2 = 102;
%% get measure data
    % get measure size
    measuresize = 0;
    totalsize  = 0;
    measptr = libpointer('int32Ptr', measuresize);
    totaptr = libpointer('int32Ptr', totalsize);
    calllib('wgfmu', 'WGFMU_getMeasureValueSize', CH1, measptr, totaptr);
    datasize = totaptr.Value;

    
    % get measure data1
    timelist = zeros([1 datasize]);
    measlist = zeros([1 datasize]);
    tptr = libpointer('doublePtr', timelist);
    mptr = libpointer('doublePtr', measlist); 
    calllib('wgfmu', 'WGFMU_getMeasureValues', CH1, 0, datasize, tptr, mptr);
    time1 = tptr.Value;
    meas1 = mptr.Value;
    
    % get measure data2
    timelist = zeros([1 datasize]);
    measlist = zeros([1 datasize]);
    tptr = libpointer('doublePtr', timelist);
    mptr = libpointer('doublePtr', measlist); 
    calllib('wgfmu', 'WGFMU_getMeasureValues', CH2, 0, datasize, tptr, mptr);
    time2 = tptr.Value;
    meas2 = mptr.Value;
        
%% save measure data
    writematrix([time1', meas1', meas2'], measure_file);
        
%% show fast plot
    hold on;
    num = 2;
    colors = ['r', 'k', 'g', 'c', 'b', 'y', 'm'];
    for i=1:num
        start = 1+datasize*(i-1)/num;
        stop = datasize*i/num;
        plot(meas1(start:stop), meas2(start:stop),colors(i));
%         scatter(meas1(start:stop), meas2(start:stop),colors(i));
%         display(meas2(10));
    end
end