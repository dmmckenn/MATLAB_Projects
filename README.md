MATLAB_Projects
===============

% Get discounted expected payoff of a lookback call option whose payoff
% is the stock's maximum price over stock_init to exp_time minus the terminal
% price of the stock. Uses Hull binomial tree parameters
% over num_periods. Performs num_iterations paths in Monte-Carlo
% simulation. Volatility of stock is voltatility, risk-free rate over
% the option's life is int_rate, and strike price is strike.
% Also computes corresponding (Monte Carlo) European call option price.
