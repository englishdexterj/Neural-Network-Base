function create_node() {
	//create hidden node
	repeat (100) {
		//choose random connection to split
		var _split_connection = irandom(ds_grid_height(connections)-1);
		if ds_grid_get(connections, 5, _split_connection) = 0 { //if connection is not already disabled
			var _in_layer = ds_grid_get(connections, 2, _split_connection);
			var _out_layer = ds_grid_get(connections, 6, _split_connection);
		
			//check if a node can be created between the two layers
			//mod 16 allows layers 0, 16, 32, 48, and 64 (input, output, and 3 hidden layers)
			if _in_layer + _out_layer > 0 and ((_in_layer + _out_layer) / 2) mod 16 = 0 {
		
				//disable connection
				ds_grid_set(connections, 5, _split_connection, 1);
				show_debug_message("Disabled Connection from: " + string(ds_grid_get(connections, 0, _split_connection)) + " and " + string(ds_grid_get(connections, 1, _split_connection)));
			
				//add node to node list
				var _height = ds_grid_height(nodes);
				ds_grid_resize(nodes, 4, _height+1);
		
				ds_grid_set(nodes, 0, _height, total_nodes); //node number
		
				ds_grid_set(nodes, 1, _height, 0); //node value
				ds_grid_set(nodes, 2, _height, ((_in_layer + _out_layer) / 2)); //node layer
				ds_grid_set(nodes, 3, _height, 1); //node math
				node_math[total_nodes] = irandom(5)+1; //only allow Sigmoid or Tanh for output nodes
				node[total_nodes] = 0;
			
				//create connections to and from the new node
				//first connection receives weight of 1
				//second connection receives split connection weight
				create_connection_from(ds_grid_get(connections, 0, _split_connection), total_nodes, 1);
				create_connection_from(total_nodes, ds_grid_get(connections, 1, _split_connection), ds_grid_get(connections, 3, _split_connection));
				
				total_nodes++;
				show_debug_message("Node Created Between: " + string(ds_grid_get(connections, 0, _split_connection)) + " and " + string(ds_grid_get(connections, 1, _split_connection)));
				exit;
			} else {
				show_debug_message("Cannot Make Node Between Connection with " + string(_in_layer) + " and " + string(_out_layer) + " layers");
			}
		}
	}
}