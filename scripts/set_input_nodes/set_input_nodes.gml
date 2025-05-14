function set_input_nodes() {
	//set input node values
	for (var i = 0; i < input_nodes; i++) {
		ds_grid_set(nodes, 1, i, i*2);
		node[i] = irandom_range(-5, 10);
	}
}