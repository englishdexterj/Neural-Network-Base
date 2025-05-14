if wait <= 0 {
	set_input_nodes();

	run_network();

	output_node_math();

	node = [];
	node[total_nodes-1] = 0;
	
	wait = 6;
} else {
	wait--;
}