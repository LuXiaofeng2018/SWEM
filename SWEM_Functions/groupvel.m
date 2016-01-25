function [ Cg ] = groupvel(k,h)

g = 9.81;

Cg = (1/(2*sqrt(g*k*tanh(k*h))))*(g*tanh(k*h) - g*k*h*((tanh(k*h))^2-1));





end

