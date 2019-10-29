# Digital Circuit Optimization

MATLAB implementation of an evolutionary algorithm for designing and optimizing digital circuits. Given a number of inputs and a target output, the algorithm finds a logical circuit that fulfills those conditions (Figure 1).

<p align="center">
    <figure>
    <img width="350" height="250" src="images/input-output.jpg">
        <figcaption>
        <br><i>Fig 1. Truth table for three inputs and a desired output (green).</i>>
        </figcaption>
    </figure>
</p>


#### Genetic Algorithm
Our population consists of different individuals, which correspond to different circuits. Those circuits are assessed according to a defined fitness. In the scope of this problem, we define the fitness to be better as its value goes towards zero (minimization problem). To do so, we will account for the output –whether the circuit produces the correct output or not– and the number of components –the number of logic gates and connections–. 

The fitness corresponds to a piecewise-defined function. It is equal to the hamming distance if it is different from 0. Otherwise, this corresponds to the sum of logic gates and connections divided by the number of logic gates squared. 

After creating the initial population of random individuals, the algorithm has three different distinctive parts:
1. **Selection**: The best individuals are selected –according to the fitness– and the rest are discarded.
2. **Recombination**: We generate offspring from the best individuals. The size of the population is kept constant.
3. **Mutation**: With a certain rate, we mutate some of the individuals to help the system to escape local minima.

#### Implementation
The algorithm outputs a connectivity matrix, such as the one depicted in figure 2. The connectivity matrix corresponds to a codification of the logic circuit. The size of this matrix will be *nInputs + nGates x nInputs + nGates*, where *nInputs* denote the number of inputs and the number of maximum gates, respectively. Since we are using the example of figure 1, our nInput corresponds to 3. The number of gates was set to 10. Also, despite this is a square matrix, it is not symmetric. Rows denote the source and the columns the destination. For example, *A* will be connected with the logic gates *4* and *6* (first row).

<p align="center">
  <img width="400" height="250" src="images/connectivity_matrix.jpg">
        <figcaption>
        <br><i>Fig 2. Connectivity matrix resulted after optimization.</i>
        </figcaption>
</p>

We can decode the connectivity matrix to form the logic circuit (figure 3). By computing the truth table, we can assert the output of the circuit. We used a color palette to highlight the input, the circuit, and the output.

<p align="center">
  <img width="400" height="200" src="images/circuit.jpg">
        <figcaption>
        <br><i>Fig 3. Circuit representation.</i>
        </figcaption>
</p>


<p align="center">
  <img width="400" height="250" src="images/table_circuit.jpg">
        <figcaption>
        <br><i>Fig 4. Truth table for the circuit generated. It produces the target output (from figure 1).</i>
        </figcaption>
</p>


#### Performance
The algorithm may get stuck to local minima e.g., hamming distance of 1. For that reason, multiple reruns with different rng may help. Figure 5 shows how the fitness evolves in time for the example proposed in this document.

<p align="center">
  <img width="500" height="350" src="images/evolution.jpg">
        <figcaption>
        <br><i>Fig 5. Evolution of best fitness (top) and average fitness (bottom).</i>
        </figcaption>
</p>


#### Installation
The code has been tested in MATLAB 2019a. The *Communications Toolbox* is necessary to run the algorithm. This dependency is expected to be removed in the future. 
The *main.m* file contains the code to run the example from this documentation and can be directly run. We have also implemented a function to make it more convenient to change diverse parameters. This function is *circuitoptimizer.m*.


#### Testing
The code has been tested for ten different cases for 2 and 3 inputs. The test files are also available in the repository. To run them, use the function *runtests()*.