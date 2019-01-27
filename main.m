%% BooleanCircuitOptimization
% Authors: mikirubio, sgalella

% Setup of the algorithm
number_iterations = 1000;
number_gates = 10;
number_individuals = 100;
mutation_rateMAX = 0.1;
number_inputs = 3;
target_output = [0 1 1 1 1 1 0 1];

% Table initialization
tabla = zeros(number_gates+number_inputs,number_gates+number_inputs,number_individuals);    % Matriz de conexiones.


% Control sequences
if length(target_output)~=2^number_inputs 
    error('Length of output objective has to be equal to 2^number_inputs.')
end

for i = 0:(2^number_inputs)-1
    inputs (i+1,:) =de2bi(i,number_inputs,'left-msb');
end

if number_gates == 1
    warning('Number of gates equals to 1. No recombination possible.')
end

fitness_hamming = zeros(1,number_individuals);
fitness_coste = zeros(1,number_individuals);
fitness_global = zeros(3,number_individuals);

% Population generation
 for k = 1:number_individuals
    tabla(:,:,k) = mutation(tabla(:,:,k),500,number_gates,number_inputs,1);
 end

 
for k = 1:number_individuals

suma_columnas(:,k) = sum(tabla(:,:,k));                                                     

suma_filas(:,k) = sum(tabla(:,:,k),2);

[estados(:,:,:), matriz_estados(:,:,k), outputs(k,:)] = output(tabla(:,:,k),number_gates, number_inputs,inputs,suma_columnas(:,k));

end

for k = 1:number_individuals
    [fitness_hamming(k)] = hamming(outputs(k,:),number_inputs,target_output);

    [fitness_coste(k)] = cost(number_inputs,number_gates,suma_columnas(:,k));
end
    [fitness_global] = fitness(fitness_hamming, fitness_coste, number_gates);

    fitness_media = mean(fitness_global(3,:));

    fitness_minima = min(fitness_global(3,:));



[seleccion_final] =selection (fitness_global, number_individuals);

optimo = cell (1,length(seleccion_final(1,:)));


for i = 1:length(seleccion_final(1,:))
    optimo{i} = tabla(:,:,seleccion_final(2,i));
end

tabla(:,:,:)= 0;
for i = 1:length(optimo)
    tabla(:,:,i)= optimo{i};
end

best_fitness = 10^20;
best_table = zeros(number_gates + number_inputs);


for niter = 2:number_iterations

    % Recombination
    if number_gates>1
        if (length(optimo)>1)
            tabla = recombination( tabla,optimo, number_gates, number_inputs, number_individuals );
        end
    end
    % Mutation
    for k = (length(optimo)+1):number_individuals
        tasa_mutacion = randi(mutation_rateMAX*100)/100;
        tabla(:,:,k) = mutation(tabla(:,:,k),ceil(number_gates/4),number_gates,number_inputs,tasa_mutacion);
    end 

    % Fitness calculation
    for k = 1:number_individuals

        suma_columnas(:,k) = sum(tabla(:,:,k));                                                     

        suma_filas(:,k) = sum(tabla(:,:,k),2);

        [estados(:,:,:), matriz_estados(:,:,k), outputs(k,:)] = output(tabla(:,:,k),number_gates, number_inputs,inputs,suma_columnas(:,k));

    end

    for k = 1:number_individuals
        [fitness_hamming(k)] = hamming(outputs(k,:),number_inputs,target_output);

        [fitness_coste(k)] = cost(number_inputs,number_gates,suma_columnas(:,k));
    end

    [fitness_global] = fitness(fitness_hamming, fitness_coste, number_gates);

    fitness_media(niter) = mean(fitness_global(3,:));

    fitness_minima(niter) = min(fitness_global(3,:));

    [seleccion_final] = selection (fitness_global,number_individuals);

    clearvars optimo

    optimo = cell (1,length(seleccion_final(1,:)));


    for i = 1:length(seleccion_final(1,:))
        optimo{i} = tabla(:,:,seleccion_final(2,i));
    end

    tabla(:,:,:)= 0;
    for i = 1:length(optimo)
        tabla(:,:,i)= optimo{i};
    end

    % Fitness calculation (keep the best)
    for k = 1:length(optimo)

        suma_columnas(:,k) = sum(tabla(:,:,k));                                                     

        suma_filas(:,k) = sum(tabla(:,:,k),2);

        [estados(:,:,:), matriz_estados(:,:,k), outputs(k,:)] = output(tabla(:,:,k),number_gates, number_inputs,inputs,suma_columnas(:,k));

        [fitness_hamming(k)] = hamming(outputs(k,:),number_inputs,target_output);

        [fitness_coste(k)] = cost(number_inputs,number_gates,suma_columnas(:,k));
    end

    fitness_global(:,1:length(optimo)) = fitness(fitness_hamming(1:length(optimo)), fitness_coste(1:length(optimo)), number_gates);


    best_table = tabla(:,:,1);
    best_fitness = fitness_global(3,1);
    best_output = outputs(1,:);
    best_hamming = fitness_hamming(1);
    best_cost = fitness_coste(1);
    gates = sum(sum(best_table)>0);
    connections = sum(sum(best_table));

    if mod(niter,250) == 0
        clc;
        fprintf('--------- Boolean Circuit Optimization ---------\n')
        fprintf("\nNumber of iterations: %d",niter);
        fprintf("\nNumber of gates: %d", gates);
        fprintf("\nNumber of connections: %d", connections);
        fprintf("\nBest hamming distance: %d",best_hamming);
        fprintf("\nBest cost: %d",best_cost);
        fprintf("\nTarget output: %s",num2str(target_output));
        fprintf("\nBest output:   %s\n\n",num2str(best_output));
        fprintf('         -------------  *  ------------\n');
    end


end

if best_hamming > 0
    warning("\nNo optimal solution could be found.")
end

subplot(2,1,1)
plot(fitness_minima,'r');
title('Minimum fitness','Fontsize',15);
xlabel('iterations','Fontsize',12);
ylabel('fitness','Fontsize',12);
subplot(2,1,2)
plot(fitness_media,'b');
title('Average fitness','Fontsize',15);
xlabel('iterations','Fontsize',12);
ylabel('fitness','Fontsize',12)
