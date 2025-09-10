function [cum_wealth, daily_incre_fact, daily_port_total] = DTMS_PPT_run(data, win_size, tran_cost,dm,bl)
%{
This function is part of the codes for the Peak Price Tracking (PPT)[1]
system. It aggressively tracks the increasing power of different assets
such that the better performing assets will receive more investment.
For any usage of this function, the following papers should be cited as
reference:
[1] Zhao-Rong Lai, Dao-Qing Dai, Chuan-Xian Ren, and Ke-Kun Huang. ?°A peak price tracking 
based learning system for portfolio selection?±, 
IEEE Transactions on Neural Networks and Learning Systems, 2017. Accepted.
[2] Zhao-Rong Lai, Dao-Qing Dai, Chuan-Xian Ren, and Ke-Kun Huang.  ?°Radial basis functions 
with adaptive input and composite trend representation for portfolio selection?±, 
IEEE Transactions on Neural Networks and Learning Systems, 2018. Accepted.
[3] Pei-Yi Yang, Zhao-Rong Lai*, Xiaotian Wu, Liangda Fang. ?°Trend Representation 
Based Log-density Regularization System for Portfolio Optimization?±,  
Pattern Recognition, vol. 76, pp. 14-24, Apr. 2018.
At the same time, it is encouraged to cite the following papers with previous related works:
[4] J. Duchi, S. Shalev-Shwartz, Y. Singer, and T. Chandra, ?°Efficient
projections onto the \ell_1-ball for learning in high dimensions,?± in
Proceedings of the International Conference on Machine Learning (ICML 2008), 2008.
[5] B. Li, D. Sahoo, and S. C. H. Hoi. Olps: a toolbox for on-line portfolio selection.
Journal of Machine Learning Research, 17, 2016.
Inputs:
data                      -data with price relative sequences
win_size                  -window size
tran_cost                 -transaction cost rate
Outputs:
cum_wealth                -cumulative wealths
daily_incre_fact          -daily increasing factors of PPT
daily_port_total          -daily selected portfolios of PPT
%}

[T N]=size(data);

cum_wealth = ones(T, 1);
daily_incre_fact = ones(T, 1);
month_incre_fact = ones(T, 1);

daily_port = ones(N, 1)/N;  
daily_port_total=ones(N, T)/N;
daily_port_o = zeros(N, 1);
epsilon_list_5 = ones(N, 1) * 5;
epsilon_list_100 = ones(N, 1) * 100;
epsilon_list_total = ones(N, 1);

a_list = zeros(N, 1);
record_a=ones(T, 1) ;
record_epsilon=ones(T, 1) ;
close_price = ones(T,N);
for i=2:T
    close_price(i,:)= close_price(i-1,:).*data(i,:);
end
run_ret = 1;
for t = 1:T

    daily_port_total(:,t)=daily_port;
    daily_incre_fact(t, 1) = (data(t, :)*daily_port)*(1-tran_cost/2*sum(abs(daily_port-daily_port_o)));

    run_ret = run_ret * daily_incre_fact(t, 1);
    cum_wealth(t) = run_ret;
    if t>win_size
        month_incre_fact = prod(daily_incre_fact(t-19:t, 1));
    end
    daily_port_o = daily_port.*data(t, :)'/(data(t, :)*daily_port);
    if t < win_size
        epsilon = 100;
        a = 0;
        epsilon_list_5(t, :) = 5;
        epsilon_list_100(t, :) = 100;
        epsilon_list_total(t, :) = epsilon;
        a_list(t, :) = a;
    else
        if month_incre_fact >1.1%
            %daily_port = ones(N, 1)/N;
            daily_port_past = daily_port_total(:,t-1);
            [epsilon_sample,a_sample] =DTMS_PSO_1(close_price,data,daily_port_past,t,tran_cost,dm,win_size);
            %pso_1 小区域的大波动
            epsilon_list_5(t, :) = epsilon_sample;
            epsilon_list_100(t, :) = 100;
            epsilon_list_total(t, :) = epsilon_sample;
            a_list(t, :) = a_sample;
            epsilon = mean(epsilon_list_5(t-4:t, :));%如果
            a = mean(a_list(t-4:t, :));%累积财富比较大，市场要变动比较小，在小范围上搜索
            %有个问题，表现好的时候又重新定义每个投资组合比例？因为要做大波动重新平衡
            %为什么收益表现好却要epsilon5，因为这时候要控制风险
        else
            daily_port = ones(N, 1)/N;
            daily_port_past = daily_port_total(:,t-1);
            [epsilon_sample,a_sample] =DTMS_PSO_2(close_price,data,daily_port_past,t,tran_cost,dm,win_size);
            %pso_1 大范围的小波动
            epsilon_list_5(t, :) = 5;
            epsilon_list_100(t, :) = epsilon_sample;
            epsilon_list_total(t, :) = epsilon_sample;
            a_list(t, :) = a_sample;
            epsilon = mean(epsilon_list_100(t-4:t, :));
            a = mean(a_list(t-4:t, :));%%累积财富比较小，市场要变动比较大，要在大范围上搜索（不用重新定义再大范围上搜索吗）
            %为什么收益表现差却要epsilon100，因为这时候要追求回报
        end
    end
    disp(epsilon)
    disp(a)
    record_a(t,:)=a;
    record_epsilon(t,:)=epsilon;
     if(t<T)
       [daily_port_n]=DTMS_PPT(close_price,data,t,daily_port,win_size,epsilon,a,dm);
       daily_port = daily_port_n;
    
    end
    
end
disp(record_a);
save('record_a.mat', 'record_a');
disp(record_epsilon);
save('record_epsilon.mat', 'record_epsilon');
end



