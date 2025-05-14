function output_node_math() {
	//apply math to output nodes
	for (var i = input_nodes; i < input_nodes+output_nodes; i++) {
		node[i] = sc_node_math(node_math[i], node[i]);
	}
}