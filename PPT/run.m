win_size = 20;
tran_cost = 0.001; 
[cum_wealth, daily_incre_fact, daily_port_total] = PPT_run(data, win_size, tran_cost);
disp(cum_wealth)