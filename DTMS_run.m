win_size = 20;
tran_cost = 0.001; 
close_price = DTMS_close_price(data);
dm = DTMS_double_moving(close_price,win_size);
[cum_wealth, daily_incre_fact, daily_port_total] = DTMS_PPT_run(data, win_size, tran_cost,dm);
disp(cum_wealth)
