function [superframe_vector, remaining_data] = superframe(data, rate)
%create a superframe from a given amount of data
%   superframe_vector : data transform into a superframe of 17ms.
%   remaining_data : 0 if all data are in the superframe (a superframe has a given size thus it is completed with 0)
%; otherwise vector of data which are not in the superframe (data > superframe length)
%
%   data : data we want to put in a superframe
%   rate : rate of the communication, calculated before


NB_FRAMES_SUPERFRAME = 69; %the 69th frame is the sync frame
SUPERFRAME_DURATION = 0.017
FRAME_DURATION = SUPERFRAME_DURATION/NB_FRAMES_SUPERFRAME; %seconds
FEC_SIZE = 8 %bits !!!!!!!!!!!!!!!see in function of the CRC salomon code!!!!!!!!!!!!!!!!!
end_data = 0 %0 : don't reach the end of data ; 1 : reach the end of data

frame_size = round(rate * FRAME_DURATION);

data_size = size(data, 2);

%Calculation of the nb of data bits in a trame
data_frame_size = frame_size - FEC_SIZE;
data_superframe_size = data_frame_size * (NB_FRAMES_SUPERFRAME-5); %non data frames : 0;1;34;35;68

superframe_vector = [];

data_treated = 0;
i=0;
while data_treated < data_superframe_size
    i = i+1;
    
    %write data in a vector
    if data_treated < data_size
        data_frame(i) = data(data_treated+1);
    end
    
    %end of data, complete vector with 0
    if data_treated >= data_size
        data_frame(i)=0;
        end_data = 1; %reach the end of data
    end
    
    data_treated = data_treated + 1;
    
    %add data_frame in superframe and reset data_frame
    if data_treated >= data_frame_size
        [Q, R] = quorem(sym(data_treated), sym(data_frame_size));
        if Q>0 && R == 0
            if Q==1 %for the first addition
                superframe_vector = frame(data_frame, FEC_SIZE);
            end
            if Q>1
                superframe_vector = [superframe_vector frame(data_frame, FEC_SIZE) ]
            end
            data_frame = zeros(1, data_frame_size);
            i=0;
        end
    end
    
    %remaining data
    if end_data == 1
        remaining_data = 0;
    end
    if end_data == 0
        for i = data_treated : data_size
            remaining_data(i-data_treated)=data(i);
        end
    end
    
end