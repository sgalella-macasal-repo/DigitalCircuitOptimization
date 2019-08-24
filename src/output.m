function [states, states_matrix, outputs] = output(table,number_gates, number_inputs,inputs,sum_columns)
% Authors: mikirubio, sgalella

% Input vector for gates
states = zeros(number_gates,2,(2^number_inputs));                                                           

% Output vector (compared to objective_output)
outputs = zeros(1,2^number_inputs);                                              

for iteracion = 1:(2^number_inputs)
   
    % Inputs and states of the gates
    states_matrix(iteracion,:) =  [inputs(iteracion,:) ,zeros(1,number_gates)];           

    
    for j=(number_inputs+1):(number_gates + number_inputs)                    
        % Case 1: one entry
        if sum_columns(j) == 1
            % Condition: number of connextions per gate
            for i=1:(number_gates+number_inputs)
                if table(i,j) == 1
                    states(j-number_inputs,1,iteracion) = states_matrix(iteracion,i);
                    states(j-number_inputs,2,iteracion) = 0;
                end
            end
            % NOR gate: Assignation output values
            if states(j-number_inputs,1,iteracion) + states (j-number_inputs,2,iteracion) >= 1
                states_matrix(iteracion,j) = 0;
            elseif states(j-number_inputs,1,iteracion) + states (j-number_inputs,2,iteracion) == 0
                states_matrix(iteracion,j) = 1;
            end
        else
            % Case 2: two entries
            if sum_columns(j)==0
                states_matrix(iteracion,j)=0;
            else
                % Case 3: three entries
                if sum_columns(j) == 2
                    a = 1;
                    for i=1:number_gates+number_inputs
                        if table(i,j) == 1
                            states(j-number_inputs,a,iteracion) = states_matrix(iteracion,i);
                            a = a + 1;
                        end
                    end
                    % NOR gate output vector assignation
                    if states(j-number_inputs,1,iteracion) + states (j-number_inputs,2,iteracion) >= 1
                        states_matrix(iteracion,j) = 0;
                    elseif states(j-number_inputs,1,iteracion) + states (j-number_inputs,2,iteracion) == 0
                        states_matrix(iteracion,j) = 1;
                    end
                end
            end
        end
    end
    puerta = 0;
    for indice = (number_inputs+1):(number_gates+number_inputs)
        if sum_columns(indice) > 0
            puerta = indice - number_inputs;
        end
    end
    outputs(iteracion) = states_matrix(iteracion,puerta+number_inputs);
end


end

