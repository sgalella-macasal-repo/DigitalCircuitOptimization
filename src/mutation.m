function table = mutation( table, mutations, number_gates, number_inputs, mutation_rate )
% Authors: mikirubio, sgalella

    for x=1:mutations
        % Connection matrix column sum vector
        suma_columnas = sum(table);                                          
        
        % i is assigned with a random value. (row coordinate). Not
        % accounting for last row
        i = randi(number_gates + number_inputs - 1);                          
        
        % Condition: No error. Not accounting last row neither penultimate.
        if i < number_gates + number_inputs - 2
            % Assignt to j a random number (function of i, column coordinate)
            j = i + randi(number_gates + (number_inputs) - i);              
        else
            % Calculation of j in last row
            j = i + 1;                                                             
        end
        
        % Restriction: No accessible areas of the matrix
        while ((i < number_inputs+1) && (j < number_inputs+1))                                                  
            i = randi(number_gates + number_inputs - 1);
            j = i + randi(number_gates + (number_inputs) - i);
        end
        
        
        if rand(1)<= mutation_rate
            if table(i,j) == 1
                    % If there is a 1 in our coordinate (row, column),
                    % equals to 0
                    table(i,j) = 0;
                    % Condition: Sum of columns cannot be greater than 2 (NOR gate)
            elseif (table(i,j) == 0 && suma_columnas(j)<2)
                    % If there is a 0 in our (row, column) coordinate,
                    % equals to 1
                    table(i,j) = 1;                                                  
            end
        end

    end

end

