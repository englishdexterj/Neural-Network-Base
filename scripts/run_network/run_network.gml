function run_network() {
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
}