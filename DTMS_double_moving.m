function [double_moving] = DTMS_double_moving(data,win_size)
[T N]=size(data);
week_moving = ones(T, N);  
month_moving = ones(T, N);  
double_moving = ones(T, N); 
%new_relative = ones(T, N); 
%DMAC=zeros(T,N);

for t = 1:T
    for n = 1:N
        if t>win_size
            week_moving(t,n) = mean(data(t-4:t,n));
            month_moving(t,n) = mean(data(t-19:t,n));
            %new_relative(t,n)= mean(data(t-4:t,n))/data(t,n);
        end
    end
end

%{
for t = 1:T
    for n = 1:N
        if t > win_size
            % 计算周EMA
            alpha_week = 2 / (5 + 1);  % 周期为5的EMA的平滑系数
            week_moving(t,n) =data(t,n) * alpha_week + (1 - alpha_week) * week_moving(t-1,n);
            % 计算月EMA
            alpha_month = 2 / (20 + 1);  % 周期为20的EMA的平滑系数
            month_moving(t,n) =data(t,n)  * alpha_month + (1-alpha_month)*month_moving(t-1,n);
        end
    end
end
%}
%{
for t = 1:T
    for n = 1:N
        if t >= win_size
            if week_moving(t-1,n)/data(t,n) ~= month_moving(t-1,n)/data(t,n)
                double_moving(t,n) = -(1/((week_moving(t,n)/data(t,n)-month_moving(t,n)/data(t,n))+1)+1/((week_moving(t-1,n)/data(t-1,n)-month_moving(t-1,n)/data(t-1,n))+1))+1;
            end
        end
    end
end
%}

for t = 1:T
    for n = 1:N
        if t < win_size
            double_moving(t,n) = 1;
        else
            if week_moving(t,n) > month_moving(t,n) 
                double_moving(t,n) = -(1/((week_moving(t,n)/data(t,n)-month_moving(t,n)/data(t,n))+1) - 1/((week_moving(t-1,n)/data(t-1,n)-month_moving(t-1,n)/data(t-1,n))+1));
            else 
                double_moving(t,n) = 1/((week_moving(t,n)/data(t,n)-month_moving(t,n)/data(t,n))+1) - 1/((week_moving(t-1,n)/data(t-1,n)-month_moving(t-1,n)/data(t-1,n))+1);  
            end
        end
    end
end

%{
for t = 1:T
    for n = 1:N
        if t < win_size
            double_moving(t,n) = 1;
        else
            if week_moving(t,n) > month_moving(t,n) 
                double_moving(t,n) = -(1/((week_moving(t,n)-month_moving(t,n))+1) - 1/((week_moving(t-1,n)-month_moving(t-1,n))+1));
            else 
                double_moving(t,n) = 1/((week_moving(t,n)-month_moving(t,n))+1) - 1/((week_moving(t-1,n)-month_moving(t-1,n))+1);  
            end
        end
    end
end
%}
