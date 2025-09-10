# DTMS-PSO: Adaptive Trend Monitoring System for Online Portfolio Selection

This repository hosts the MATLAB code for the experimental section of the paper "An Adaptive Trend Monitoring System Using Particle Swarm Optimization." It implements the DTMS-PSO system for online portfolio selection, which uses Particle Swarm Optimization (PSO) to dynamically adjust parameters according to recent market performance.

# 1. Copyright Statement
This code repository is the official implementation of the paper "An Adaptive Trend Monitoring System Using Particle Swarm Optimization". The account owner is the original author of the paper and the source code. File usage instructions for the project will be supplemented at a later date.
The code files for this repository are currently being uploaded. If you reference this project, please notify us via an issue. Thank you!

# 2. Brief Instructions
## 2.1 DTMS_run.m
This is the main execution script. Running this script after configuring the parameters will initiate the entire DTMS-PSO system workflow, including data preprocessing, trend indicator calculation, PSO optimization, and portfolio optimization.

## 2.2 DTMS_PPT_run.m
This is the core function file. It contains the main loop for online portfolio selection and implements the logic for adaptively selecting PSO strategies based on recent performance.

## 2.3 DTMS_PSO_1.m & DTMS_PSO_2.m
These are the Particle Swarm Optimizer functions. The PSO optimizer used for narrow-range, fine-grained searches when recent performance has been strong. And the PSO optimizer used for broad-range exploration and rebalancing when recent performance has been poor.

## 2.4 Auxiliary Files
DTMS_target.m is the objective function. Used during the PSO optimization process to evaluate the quality of each particle .
DTMS_double_moving.m is the dynamic trend strength indicator calculation function. Computes the trend signal strength for assets based on the double moving average strategy. DTMS_close_price.m and simplex_projection_selfnorm2.m used for price processing, portfolio weight projection calculations.

# 3. Abstract of the Paper
Online Portfolio Selection (OLPS) is a crucial research domain that combines financial markets with machine learning techniques, attracting extensive scholarly attention. However, existing OLPS methods often suffer from two main limitations: insufficient exploration of quantitative financial strength signal and a lack of adaptive parameter optimization mechanisms that dynamically respond to recent market performance. Therefore, we propose an adaptive trend monitoring system using particle swarm optimization to analyze market trend changes from multiple perspectives, which we abbreviate as DTMS-PSO. Inspired by the double-moving average strategy, we first propose a dynamic trend strength indicator to assess the strength of financial signals and adjust it through historical information parameters. Subsequently, we combine this indicator with relative peaks to form the investment potential scores. Considering the recent market performance over the past month, we incorporate the dynamic adjustment mechanism to flexibly adjust parameter update strategies and search scope of the particle swarm optimization (PSO) algorithm. This mechanism adjusts based on real-time portfolio performance to ensure effective updates of update step parameters and historical information parameters. Finally, we use a fast error back propagation (BP) algorithm to feed investment potential scores back to investment proportions via gradient projection to maximize wealth accumulation objectives. Empirical comparative analysis, statistical tests, and ablation experiments on five datasets comparison with 10 OPLS models demonstrate that DTMS-PSO outperforms all other models in overall performance. In terms of cumulative wealth for profit potential, DTMS-PSO exceeds most of the models by at least 13%; and in terms of Sharpe ratio for measuring risk mitigation capabilities, it surpasses most of the models by at least 5%.

The crucial contributions of this study are as follows:
- Inspired by the double moving average strategy, we propose a novel dynamic trend strength indicator, which quantifies the strength of financial signals by analyzing the difference between the short-term and long-term relative moving average of the current period and those of the previous period. This indicator breaks through the limitation of traditional double moving average strategy which can only provide binary signals, and more accurately captures the strength of asset prices.
- We propose a new parameter optimization strategy where we adopt different particle swarm optimization strategies according to varying recent market performance, overcoming the limitation of traditional investment strategies that rely on a single decision-making mechanism and fail to adapt to dynamic market changes. Specifically, during strong market performance over the past month, our method focuses on fine-tuning optimal solutions within a narrow range. Conversely, when the market performs poorly over the past month, our method address this by rebalancing portfolio allocations and expanding our search to identify superior solutions over a broader range.
- We develop a novel adaptive trend monitoring system using particle swarm optimization, which comprehensively analyzes market dynamics and responds to market conditions through dynamic mechanisms with targeted adjustments. Extensive experiments on five financial datasets demonstrate the system's superior effectiveness. Compared to 10 state-of-the-art OLPS benchmarks, DTMS-PSO exhibits significant profit potential and risk mitigation capabilities.

## 4. Flowchart
<img width="421" height="623" alt="image" src="https://github.com/user-attachments/assets/99991f38-5afe-46c4-ba8f-16f981c446d6" />
Fig.1 The DTMS-PSO system flow

## 5. Results Visualization

<img width="1049" height="727" alt="image" src="https://github.com/user-attachments/assets/aa2a098f-575c-402c-99c1-db505d0f45ae" />
Fig.2 the cumulative wealth trends on SP500

<img width="1063" height="716" alt="image" src="https://github.com/user-attachments/assets/9c8813b6-98a6-4e3a-a1d5-6a8441772c18" />
Fig.3 the cumulative wealth trends on DJIA

<img width="1059" height="726" alt="image" src="https://github.com/user-attachments/assets/5f96a0ef-60e5-48e1-ade6-948d089875c3" />
Fig.4 the cumulative wealth trends on HK50

<img width="1054" height="707" alt="image" src="https://github.com/user-attachments/assets/f4956125-9cc9-4da2-a364-b588088a2c04" />
Fig.5 the cumulative wealth trends on HSCIM

<img width="997" height="709" alt="image" src="https://github.com/user-attachments/assets/c529bfb0-af8d-4c02-a7ca-c3c0bc4884b9" />
\Fig.6 the cumulative wealth trends on NYSE(N)

## 6. Contact us for cooperation or consultation
If you have any questions, please contact the author's work email or leave a message in issues. The author will try his best to answer them at his convenience.If you are interested in seeking cooperation, you can also consult this email. Author contact email: 2112464128@e.gzhu.edu.cn
