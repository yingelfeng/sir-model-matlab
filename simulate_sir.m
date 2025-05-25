function I_model = simulate_sir(params, t_data, S0, I0, R0)
    beta = params(1);
    gamma = params(2);
    
    y0 = [S0; I0; R0];
    [~, y] = ode45(@(t, y) sir_model(t, y, beta, gamma), t_data, y0);
    
    I_model = y(:, 2);  
end