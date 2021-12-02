function EOPs= GetEOPs(IMU,GPS,Frameindex)
EOPs=zeros(size(Frameindex,1),7);
%Loop around each frame 
for frame=1:size(Frameindex,1)
    time_stamp = Frameindex(frame,2); %Get the time stamp for each frame
    [~, closest_Idx] = min(abs(IMU(:,7)-time_stamp)); %Index of closest time stamp
    closest_stamp_value = IMU(closest_Idx,7); %Get the closest time stamp value
    if closest_stamp_value == time_stamp
        %time1 and time2 are same and therefore the ratio should be 1
        time1=IMU(closest_Idx,[7 11:13]); 
        time2=IMU(closest_Idx,[7 11:13]);
    elseif closest_stamp_value < time_stamp
        time1 = IMU(closest_Idx,[7 11:13]);
        time2 = IMU(closest_Idx+1,[7 11:13]);
    else
        time1 = IMU(closest_Idx-1,[7 11:13]);
        time2 = IMU(closest_Idx,[7 11:13]);
    end
    %Calculate the ratio using linear interpolation
    stamp_ratio = ( time_stamp - time1(1) ) / ( time2(1) - time1(1) );
    stamp_ratio_2=( time2(1)- time_stamp) / ( time2(1) - time1(1) );
    %Add the interpolated time in the extracted UTM time  
    Time = [time1(2) time1(3) (time1(4)*stamp_ratio_2+stamp_ratio*time2(4))];
    %Convert the UTM time to the Seconds of the day
    Time_sec = Time(1)*3600 + Time(2) * 60 + Time(3);
    
    %Use the seconds of the day and compare it with the GPS receiver
    %seconds of the day to extract the position and orientation
    [~, closest_GPS] = min(abs(GPS(:,1)-Time_sec));
    v_closest_time = GPS(closest_GPS,1);
    if v_closest_time == Time_sec
        %time1 and time2 are same and therefore the ratio should be 1
        EOPs1 = GPS(closest_GPS,[1 5:10]);
        EOPs2 = GPS(closest_GPS,[1 5:10]);
    elseif v_closest_time > Time_sec
        EOPs1 = GPS(closest_GPS-1,[1 5:10]);
        EOPs2 = GPS(closest_GPS,[1 5:10]);
    else
        EOPs1 = GPS(closest_GPS,[1 5:10]);
        EOPs2 = GPS(closest_GPS+1,[1 5:10]);
    end
    ratio_time = ( Time_sec - EOPs1(1) ) / ( EOPs2(1) - EOPs1(1) );
    ratio_time_2 = (EOPs2(1)- Time_sec) / ( EOPs2(1) - EOPs1(1) );
    EOPs(frame,:) = EOPs1*ratio_time_2 + EOPs2*ratio_time;
end


%------Obslete function, Not able to handle if two minimum values ocur only on 1 side of timestamp 
% TR: June_20_2019 

% %Loop around each frame 
% for frame=1:size(Frameindex)
%     time_stamp = Frameindex(frame,2); %Get the time stamp for each frame
%     [~, Idx] = sort(abs(IMU(:,7)-time_stamp)); %Indexes of closest time stamp
%     min_idx=Idx(1,1);    second_min_idx=Idx(2,1); %Find Index of two closest times
%     val_1=IMU(min_idx,[7 11:13]);   val_2=IMU(second_min_idx,[7 11:13]); %Value to two closest time stamps  
%     time1=min(val_1,val_2);
%     time2=max(val_1,val_2);
%     combined_time(frame)=time2(1)';
%     ratio_ts = ( time_stamp - time1(1) ) / ( time2(1) - time1(1) );
%     Time = [time1(2) time1(3) time1(4) + ratio_ts * (time2(4) - time1(4))];
%     Time_sec(frame) = Time(1)*3600 + Time(2) * 60 + Time(3);
%     Time_sec=Time_sec';
% end

%
end

