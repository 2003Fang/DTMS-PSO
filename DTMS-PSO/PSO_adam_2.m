function [epsilon,a] = PSO_adam_2(close_price,data,daily_port_past,t,tran_cost,dm,win_size)
rng(0);
% Initialize variables
max_iterations = 600; % Maximum number of iterations
swarm_size = 50; % Size of the particle swarm
omega = 1e-3; % Inertia weight
c1 = 1e-3; % Cognitive coefficient
c2 = 5e-5; % Social coefficient
learning_rate_1 = 0.1; % epsilon学习率0.1
learning_rate_2 = 5e-5; % a学习率
tolerance = 1e-6; % 收敛容差
m_epsilon=0;
v_epsilon=0;
m_a=0;
v_a=0;
beta1 = 0.9; beta2 = 0.999; eps = 1e-8;
% Randomly initialize the particle positions and velocities within the specified range
epsilon_position = rand(1, swarm_size) + 5;
a_position = -0.5 + rand(1, swarm_size);%这个值是用于调整加入信号强弱的指数。这个值的大小被设置为-0.5-0.5之间
epsilon_velocity = zeros(1, swarm_size);
a_velocity = zeros(1, swarm_size);

% Evaluate the fitness function for each particle
% 从50次中随机选择确定让目标值最大的那个值和具体第几个，a_position(i)用于确定提出该指标的参数，
%epsilon_position(i),确定投资组合比例，用5是控制风险和成本，用100是为了追求回报
fitness = zeros(1, swarm_size);
for i = 1:swarm_size
    %fitness(i) = target(close_price, data, daily_port_past, win_size, epsilon_position(i), t, tran_cost, a_position(i), dm,win_size);
    fitness(i) = DTMS_target(close_price, data, daily_port_past,  epsilon_position(i), t, tran_cost, a_position(i), dm, win_size);

end

% Find the best particle (global best)
[best_fitness, best_index] = max(fitness);
global_best_epsilon = epsilon_position(best_index);%best_index是在1：swarm_size之间
global_best_a = a_position(best_index);%局部最优解，其实是初始化了一个局部最优解，然后在这个的基础上对该参数进行优化

% Store the best fitness value for each iteration
fitness_history = zeros(1, max_iterations+1);
target_record = zeros(1, max_iterations+1);
fitness_history(1) = best_fitness;
target_record(1)=fitness_history(1);
% Particle swarm optimization loop（对局部最优解进行优化）
for iter = 1:max_iterations
    % Update particle positions and velocities
    if iter<0.8*max_iterations
    % Update particle positions and velocities
        for i = 1:swarm_size
            % Update velocity 更新速度，当前位置与自身历史最优位置之间的距离和方向，粒子当前位置与群体历史最优位置之间的距离和方向。
            epsilon_velocity(i) = omega * epsilon_velocity(i) + c1 * rand() * (epsilon_position(i) - epsilon_position(best_index)) + c2 * rand() * (epsilon_position(i) - global_best_epsilon);
            a_velocity(i) = omega * a_velocity(i) + c1 * rand() * (a_position(i) - a_position(best_index)) + c2 * rand() * (a_position(i) - global_best_a);

            % Update position
            epsilon_position(i) = epsilon_position(i) + epsilon_velocity(i);
            a_position(i) = a_position(i) + a_velocity(i);

            % Evaluate fitness for the new position
            %fitness(i) = target(close_price, data, daily_port_past, win_size, epsilon_position(i), t, tran_cost, a_position(i), dm);
            fitness(i) = DTMS_target(close_price, data, daily_port_past, epsilon_position(i), t, tran_cost, a_position(i), dm, win_size);

            % Update best position (particle best)
            if fitness(i) > best_fitness
                best_fitness = fitness(i);
                best_index = i;
            end
        end

        % Update global best
        if best_fitness > fitness_history(iter)%一开始是大于初始值的局部最优解的适应值才更新局部位置，并且更新拟合值最优位置
            global_best_epsilon = epsilon_position(best_index);
            global_best_a = a_position(best_index);
        end

        % Store the best fitness value for this iteration
        fitness_history(iter+1) = best_fitness;
        target_record(iter+1)=fitness_history(iter+1);
    else
        h_1 = 1*(1+rand()); %1-2

        grad_1 = ( DTMS_target(close_price, data, daily_port_past, global_best_epsilon+h_1, t, tran_cost, a_position(i), dm, win_size)- DTMS_target(close_price, data, daily_port_past, global_best_epsilon-h_1, t, tran_cost, a_position(i), dm, win_size))/(2*h_1);
        %if norm(grad_1) < tolerance
            %break
        %end
        m_epsilon = beta1*m_epsilon - (1-beta1)*grad_1;
        v_epsilon = beta2*v_epsilon + (1-beta2)*grad_1^2;
        m_hat = m_epsilon / (1 - beta1^iter);
        v_hat = v_epsilon / (1 - beta2^iter);
        step_size= learning_rate_1*(sqrt(1-beta2^(iter)))/(1-beta1^(iter));
        alpha1 = step_size*m_hat / (sqrt(v_hat) + eps);
        global_best_epsilon = global_best_epsilon + alpha1 *grad_1;

        h_2 = 1e-3*(1+rand());%1e-3-2e-3
        grad_2 = (DTMS_target(close_price, data, daily_port_past, global_best_epsilon, t, tran_cost, global_best_a+h_2, dm, win_size)-DTMS_target(close_price, data, daily_port_past, global_best_epsilon, t, tran_cost, global_best_a-h_2, dm, win_size))/(2*h_2);
        %if norm(grad_2) < tolerance
            %break
        %end
        m_a = beta1*m_a - (1-beta1)*grad_2;
        v_a = beta2*v_a + (1-beta2)*grad_2^2;
        m_hat = m_a / (1 - beta1^iter);
        v_hat = v_a/ (1 - beta2^iter);
        step_size= learning_rate_2*(sqrt(1-beta2^(iter)))/(1-beta1^(iter));
        alpha2 = step_size*m_hat / (sqrt(v_hat) + eps);
        global_best_a = global_best_a + alpha2*grad_2;
        target_record(iter+1)=DTMS_target(close_price, data, daily_port_past, global_best_epsilon, t, tran_cost, global_best_a, dm, win_size);
    end
        
% Set the optimal values as the global best at the end of optimization
epsilon = global_best_epsilon;
a = global_best_a;
%disp("------------------------------输出值啦---------------------------------------");
%disp(target_record);
end