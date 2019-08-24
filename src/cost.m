function cost_fitness = cost(number_inputs,number_gates,sum_columns)
% Authors: mikirubio, sgalella

useful_gates = 0;

for num_puerta = (number_inputs+1):(number_gates+number_inputs)
    if sum_columns(num_puerta)>0
        useful_gates = useful_gates + 1;
    end
end
cost_fitness = sum(sum_columns) + useful_gates;

end

