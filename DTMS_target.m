function [daily_incre_fact] = DTMS_target(close_price,data,daily_port_past,epsilon,t,tran_cost,a,dm,win_size)
nstk=size(data,2);
tplus1 = t-1;
if tplus1<win_size+1
   x_tplus1=(data(tplus1,:));
   else
   closebefore=close_price((tplus1-win_size+1):(tplus1),:);
   closepredict=max(closebefore);
   x_tplus1 = (closepredict./close_price(tplus1,:))+a*dm(tplus1,:);
end

onesd=ones(nstk,1);
x_tplus1_cent=(eye(nstk)-onesd*onesd'/nstk)*x_tplus1';%中心化

if norm(x_tplus1_cent)~=0
daily_port = daily_port_past+epsilon*x_tplus1_cent/norm(x_tplus1_cent);%投资组合比例调整
daily_incre_fact = data(t, :)*daily_port*(1-tran_cost/2*sum(abs(daily_port-daily_port_past)));

end