%% HEADER 
%{
COVID-19 SPREAD MATLAB LEARNING PROJECT YIPPEE
Author: Yingel Feng
Date: 2025-05-22

Inputs:     
Outputs:    

Functions: sir_model.m

--- Revision History ---
2025-05-22: Initial commit with SIR model and import of data

%}

% --- Imports real data from Our World in Data ---
data = readtable('owid-covid-data.csv');  % import real data
canadaData = data(strcmp(data.location, 'Canada'), :);
startDate = datetime(2021, 12, 1);
endDate = datetime(2022, 5, 30);
mask = (canadaData.date >= startDate) & (canadaData.date <= endDate); % filter dates from jan-jun 2020
canadaData = canadaData(mask, :);

newCases = canadaData.new_cases;
newCases = fillmissing(newCases, 'linear');   % Fill gaps

% Rolling sum over 14 days to approximate active cases
window = 14;
activeCases = movsum(newCases, [window-1, 0]);  % sum of today and past 13 days

% Normalize to fraction of population
population = canadaData.population(1);
I_data = activeCases / population;
t_data = days(canadaData.date - canadaData.date(1));

firstValid = find(I_data > 0, 1);  % first index with nonzero infection
I_data = I_data(firstValid:end);
t_data = t_data(firstValid:end);



% --- Test of sir_model ---
y0 = [1; 0.046; 0];
tspan = [0 180]; 
beta = 0.3;
gamma = 0.1;

[t, y] = ode45(@(t, y) sir_model(t, y, beta, gamma), tspan, y0);



% --- Fitting model to data --- 

initialParams = [0.3, 0.1];  

% Initial population state from data
I0 = I_data(1);          
S0 = 1 - I0;             
R0 = 0;                  

% Optimize beta and gamma to fit the data
bestParams = fminsearch(@(params) fit_error(params, t_data, I_data, S0, I0, R0), initialParams);
beta_fit = bestParams(1);
gamma_fit = bestParams(2);
fprintf('Best-fit beta: %.4f\n', beta_fit);
fprintf('Best-fit gamma: %.4f\n', gamma_fit);

I_fit = simulate_sir([beta_fit, gamma_fit], t_data, S0, I0, R0);


% ----- PLOTTING -----
% Real infected cases
figure;
plot(t_data, I_data, 'r', 'LineWidth', 2);
xlabel('Days since Dec 1, 2021');
ylabel('Fraction of population infected');
title('Canada Active COVID-19 Cases (Dec 2021–May 2022)');
grid on;

% Model test
figure;
plot(t, y(:,1), 'b', 'LineWidth', 2); hold on;
plot(t, y(:,2), 'r', 'LineWidth', 2);
plot(t, y(:,3), 'g', 'LineWidth', 2);
xlabel('Time (days)');
ylabel('Population Fraction');
legend('Susceptible', 'Infected', 'Recovered');
title('SIR Epidemic Model');
grid on;

% Fitting
figure;
plot(t_data, I_data, 'ro', 'DisplayName', 'Real Data');
hold on;
plot(t_data, I_fit, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted SIR Model');
xlabel('Days');
ylabel('Fraction Infected');
title('Fitted SIR Model vs COVID Data');
legend();
grid on;