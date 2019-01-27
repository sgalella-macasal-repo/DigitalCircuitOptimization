function selected_individuals = selection(global_fitness,number_individuals)
% Authors: mikirubio, sgalella

operador_fitness = global_fitness(3,:);

if min(global_fitness(1,:))==0
    individuos = number_individuals/4;
else
    individuos = number_individuals/2;
end
    
    for i = 1:ceil(individuos)
        [selected_individuals(1,i),selected_individuals(2,i)] = min(operador_fitness);
        operador_fitness(selected_individuals(2,i)) = 10^11;
    end
    

end

