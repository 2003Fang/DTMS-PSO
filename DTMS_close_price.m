function [close_price] = DTMS_close_price(data)
[T N]=size(data);
close_price = ones(T,N);
for i=2:T
    close_price(i,:)= close_price(i-1,:).*data(i,:);
end
end

