function [dydt] = sir_model(t,y)
%{
--- Inputs ---
t: time
s: suceptible population
i: infected
r: recovered

--- Outputs ---
dS: derivative of s
dI: derivative of i
dR: derivative of r

%}

BETA = 0.075; % transmission rate
GAMMA = 0.03; % recovery rate

s = y(1);
i = y(2);
r = y(3);

dS = -BETA*s*i;
dI = BETA*s*i - GAMMA*i;
dR = GAMMA*i;

dydt = [dS; dI; dR];
end