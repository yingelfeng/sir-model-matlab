function error = fit_error(params, t_data, I_data, S0, I0, R0)
    I_model = simulate_sir(params, t_data, S0, I0, R0);
    error = sum((I_model - I_data).^2);  % Least-squares error
    % disp(['beta = ', num2str(params(1)), ', gamma = ', num2str(params(2)), ', error = ', num2str(error)]);

end
