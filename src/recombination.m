function table = recombination( table,optimum, number_gates, number_inputs, number_individuals )
% Authors: mikirubio, sgalella

    for i = length(optimum)+1:(number_individuals)

        columnas_hija = ones(1,number_inputs+number_gates);
        tabla_hija = zeros(number_gates+number_inputs);
        while sum(columnas_hija)>0

            padre = randi(length(optimum));
            madre = randi(length(optimum));
            while padre == madre
                madre = randi(length(optimum));
            end

            tabla_padre = table(:,:,padre);
            tabla_madre = table(:,:,madre);

            tipo_recombinacion(i-length(optimum)+1) = randi(3);

            % Vertical split
            if tipo_recombinacion(i-length(optimum)+1) == 1
               corte_vertical = number_inputs + randi(number_gates-1);
               tabla_hija(:,1:corte_vertical) = tabla_padre(:,1:corte_vertical);
               tabla_hija(:,(corte_vertical+1):(number_gates+number_inputs))=tabla_madre(:,(corte_vertical+1):(number_gates+number_inputs));
            % Horizontal split
            elseif tipo_recombinacion(i-length(optimum)+1) == 2
               corte_horizontal = randi(number_gates+ number_inputs -1);
               tabla_hija(1:corte_horizontal,:) = tabla_padre(1:corte_horizontal,:);
               tabla_hija((corte_horizontal+1):(number_gates+number_inputs),:)=tabla_madre((corte_horizontal+1):(number_gates+number_inputs),:);
            % Mixed split
            elseif tipo_recombinacion(i-length(optimum)+1) == 3
               corte_vertical = number_inputs+ randi(number_gates-1);
               corte_horizontal = number_inputs+ randi(number_gates-1);
               tabla_hija(1:corte_horizontal,1:corte_vertical)=tabla_padre(1:corte_horizontal,1:corte_vertical);
               tabla_hija(1:corte_horizontal,(corte_vertical+1):(number_gates+number_inputs))=tabla_madre(1:corte_horizontal,(corte_vertical+1):(number_gates+number_inputs));
               if rand(1)<0.5
                  tabla_hija((corte_horizontal+1:number_gates+number_inputs),:)= tabla_padre((corte_horizontal+1:number_gates+number_inputs),:);
               else
                  tabla_hija((corte_horizontal+1:number_gates+number_inputs),:)= tabla_madre((corte_horizontal+1:number_gates+number_inputs),:);
               end
            end
            columnas_hija = sum(tabla_hija);
            columnas_hija = columnas_hija > 2;
        end
        table(:,:,i) = tabla_hija;

    end

end

