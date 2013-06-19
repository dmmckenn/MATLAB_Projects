function call_price = GetMCLookbackCallPrice( stock_init, strike, num_periods, volatility, exp_time, int_rate, num_iterations)
% Get discounted expected payoff of a lookback call option that pays the
% arithmetically averaged price of a stock (currently priced at stock_init)
% that expires at exp_time (in years). Uses Hull binomial tree parameters
% over num_periods. Performs num_iterations paths in Monte-Carlo
% simulation. Volatility of stock is voltatility, risk-free rate over
% the option's life is int_rate, and strike price is strike.

delta_t = exp_time/num_periods;
u = exp(volatility*sqrt(delta_t));
d = 1/u;
q = (exp(int_rate*delta_t) - d)/(u - d);
payoff_total = 0;
discount = exp(-int_rate*exp_time);
euro_total = 0;

for i = 1:num_iterations
    s = stock_init;
    s_max = s;
    for j = 1:num_periods
        if (random('unif',0,1) < q)
            s = u*s;
        else
            s = d*s;
        end
        if (s > s_max)
            s_max = s;
        end
    end
    payoff = max(s_max - strike, 0);
    euro_payoff = max(s - strike, 0);
    payoff_total = payoff_total + discount*payoff;
    euro_total = euro_total + discount*euro_payoff;
end

fprintf('Lookback call price: %6f\nEuro call price: %6f', payoff_total/num_iterations, euro_total/num_iterations);
call_price = payoff_total/num_iterations;
