# DTMS-PSO: Adaptive Trend Monitoring System for Online Portfolio Selection

This repository hosts the MATLAB code for the experimental section of the paper "An Adaptive Trend Monitoring System Using Particle Swarm Optimization." It implements the DTMS-PSO system for online portfolio selection, which uses Particle Swarm Optimization (PSO) to dynamically adjust parameters according to recent market performance.

DTMS-PSO enhances traditional peak-price-tracking methods by:

- Introducing a dynamic trend strength indicator based on dual moving averages.

- Using PSO to adaptively optimize key parameters (α and ε) based on recent portfolio performance.

- Implementing a gradient projection method to update portfolio weights and maximize cumulative wealth.

The system outperforms 10 state-of-the-art online portfolio selection strategies across multiple financial datasets in terms of cumulative wealth, annualized return, and risk-adjusted metrics.

Some core components are not publicly available due to patent pending. A full version will be released after the paper is published.

<img width="1049" height="727" alt="image" src="https://github.com/user-attachments/assets/aa2a098f-575c-402c-99c1-db505d0f45ae" />
<img width="1063" height="716" alt="image" src="https://github.com/user-attachments/assets/9c8813b6-98a6-4e3a-a1d5-6a8441772c18" />
<img width="1059" height="726" alt="image" src="https://github.com/user-attachments/assets/5f96a0ef-60e5-48e1-ade6-948d089875c3" />
<img width="1054" height="707" alt="image" src="https://github.com/user-attachments/assets/f4956125-9cc9-4da2-a364-b588088a2c04" />
<img width="997" height="709" alt="image" src="https://github.com/user-attachments/assets/c529bfb0-af8d-4c02-a7ca-c3c0bc4884b9" />

The system was evaluated on five datasets:
DJIA, NYSE(N), SP500, HK50, HSCIM

DTMS-PSO achieved:

- Highest cumulative wealth on 4/5 datasets

- Superior Sharpe and Calmar ratios

- Statistically significant outperformance against 10 benchmarks
