function x_n = signal3( n )
%SINAL Summary of this function goes here
%   Detailed explanation goes here

x_n = zeros(length(n),1);

for i=1:length(n),
    if (n(i) >= -50) && (n(i) < 50),
        x_n(i) = 2*sin(0.02*pi*n(i));
    end;
end