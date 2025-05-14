wait = irandom(5); //10 updates a second instead of 60

input_nodes = 3;
output_nodes = 3;
total_nodes = input_nodes + output_nodes;

//create input and output nodes
nodes = ds_grid_create(4, input_nodes + output_nodes);
for (var i = 0; i < input_nodes + output_nodes; i++) {
	ds_grid_set(nodes, 0, i, i); //node number
	ds_grid_set(nodes, 1, i, 0); //node value
	if i >= input_nodes { //if node is an output
		ds_grid_set(nodes, 2, i, 64); //node layer
		ds_grid_set(nodes, 3, i, 1); //node math
		node_math[i] = irandom(1)+1; //only allow Sigmoid or Tanh for output nodes
	} else {
		ds_grid_set(nodes, 2, i, 0); //node layer
		ds_grid_set(nodes, 3, i, 0); //node math
		node_math[i] = 0;
	}
	node[i] = 0;
}

connections = ds_grid_create(7, 1);
ds_grid_sort(nodes, 0, true);

repeat (4) { //create random connections
	create_connection();
	create_connection();
	create_node();
}

//sort so it is easier to run through neural net connections
ds_grid_sort(connections, 0, true); //sort by in node first
ds_grid_sort(connections, 2, true); //then sort by layer

ds_grid_sort(nodes, 0, true);

//set input node values
for (var i = 0; i < input_nodes; i++) {
	ds_grid_set(nodes, 1, i, i*2);
	node[i] = irandom_range(-5, 10);
}

var current_node = -4;
for (var i = 0; i < ds_grid_height(connections); i++) {
	if ds_grid_get(connections, 5, i) = 0 { //if connection is not disabled
	
		//since the connections are sorted by in node and layer, all of the same input nodes should be together
		//that allows a node math to occur only once when the current_node changes
		if node[ds_grid_get(connections, 0, i)] != current_node {
			var current_node = node[ds_grid_get(connections, 0, i)];
		
			//apply node math to current node
			node[ds_grid_get(connections, 0, i)] = sc_node_math(node_math[ds_grid_get(connections, 0, i)], node[ds_grid_get(connections, 0, i)]);
		}
	
		//add in node value * connection weight to out node value
		node[ds_grid_get(connections, 1, i)] += node[ds_grid_get(connections, 0, i)] * ds_grid_get(connections, 3, i);
	}
}

//apply math to output nodes
for (var i = input_nodes; i < input_nodes+output_nodes; i++) {
	node[i] = sc_node_math(node_math[i], node[i]);
}

for (var i = 0; i < array_length(node); i++) {
	show_debug_message("Node " + string(i) + ": " + string(node[i]));
}

node = [];
node[total_nodes-1] = 0;

for (var i = 0; i < array_length(node); i++) {
	show_debug_message("Node " + string(i) + ": " + string(node[i]));
}