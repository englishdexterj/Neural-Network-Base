This project is the base design for a real-time neural network simulation
Based off a paper published by Kenneth Stanley and Risto Miikkulainen at UT Austin. https://nn.cs.utexas.edu/downloads/papers/stanley.ec02.pdf

The functionality of this project allows for a thousand or so simple neural networks to run simultaneously
These neural nets can be used to generate offspring with mutations which can create new connections, create new input nodes (to add new senses), and create new hidden nodes between existing connections.

There are 7 possible functions a node can have (sigmoid, tanh, ReLU 1, ReLU 2, Leaky ReLU, Swish, and nothing)
Nodes and connections are held in grids. Each node has a layer (showing its place in the network) associated so it can perform calculations from beginning to end

Using this base, it can be used in future projects to perform large scale simulations as the functionality already runs and creates the networks.
It can be used to let neural nets compete for the same resources or perform the same task to determine best fit
