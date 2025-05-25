function [dydt] = sir_model(t,y, BETA, GAMMA)
%{
--- Inputs ---
t: time
y1: suceptible population
y2: infected
y3: recovered
BETA: beta
GAMMA: gamma

--- Outputs ---
dS: derivative of s
dI: derivative of i
dR: derivative of r

%}

s = y(1);
i = y(2);
r = y(3);

dS = -BETA*s*i;
dI = BETA*s*i - GAMMA*i;
dR = GAMMA*i;

dydt = [dS; dI; dR];
end