function global_fitness = fitness(hamming_fitness, cost_fitness, number_gates)
% Authors: mikirubio, sgalella

global_fitness(1,:) = hamming_fitness;
global_fitness(2,:) = cost_fitness;
for i = 1:length(hamming_fitness)
    if hamming_fitness(i) == 0 
        global_fitness(3,i) = (number_gates*hamming_fitness(i)+cost_fitness(i)/number_gates)/number_gates;
    elseif hamming_fitness(i) > 0
        global_fitness(3,i) = (number_gates*hamming_fitness(i))/number_gates;

    end
        
end

end

