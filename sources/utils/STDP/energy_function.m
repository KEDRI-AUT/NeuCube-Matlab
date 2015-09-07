function [ energy ] = energy_function( time, STDP_lrate )
%ENERGY_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
lambda=0.8;
energy=STDP_lrate*exp(-lambda*time);

end

