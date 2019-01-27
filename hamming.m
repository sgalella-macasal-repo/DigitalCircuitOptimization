function hamming_fitness = hamming(outputs,number_inputs,target_output)
% Authors: mikirubio, sgalella

    hamming_fitness = 0;
    % Comparison output vectors and target_output
    for indice_salida = 1:(2^number_inputs)                                         
        if outputs(indice_salida)~= target_output(indice_salida)
            hamming_fitness = hamming_fitness + 1;
        end
    end

end

