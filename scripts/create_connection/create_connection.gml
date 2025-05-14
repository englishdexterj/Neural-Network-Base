function create_connection() {
	repeat(100) { //continously try to create a connection
		//chose 2 random nodes to try and create a connection
		node_1 = irandom(ds_grid_height(nodes)-1);
		node_2 = irandom(ds_grid_height(nodes)-1);
	
		//if node_1 layer is larger than node_2, switch them
		if ds_grid_get(nodes, 2, node_1) > ds_grid_get(nodes, 2, node_2) {
			var node_3 = node_1;
			node_1 = node_2;
			node_2 = node_3;
		}
	
		var global_connection = -4;
		if ds_grid_get(nodes, 2, node_1) < ds_grid_get(nodes, 2, node_2) {
			//search for connection in global connection list
			for (var j = 0; j < ds_grid_height(global.connections); j++) {
				//if connection exists, return global connection id
				if ds_grid_get(global.connections, 0, j) = node_1 and ds_grid_get(global.connections, 1, j) = node_2 {
					var global_connection = ds_grid_get(global.connections, 2, j);
					break;
				}
			}
		
			//if connection has never been made, add to global connection list
			if global_connection = -4 {
				ds_grid_resize(global.connections, 3, ds_grid_height(global.connections)+1);
				ds_grid_set(global.connections, 0, ds_grid_height(global.connections)-1, node_1);
				ds_grid_set(global.connections, 1, ds_grid_height(global.connections)-1, node_2);
				ds_grid_set(global.connections, 2, ds_grid_height(global.connections)-1, ds_grid_height(global.connections));
				var global_connection = ds_grid_height(global.connections);
				show_debug_message("New Global Connection between: " + string(node_1) + " and " + string(node_2));
			}
		
			//check if connection already made in current neural net
			var connection_exists = false;
			for (var k = 0; k < ds_grid_height(connections); k++) {
				if ds_grid_get(connections, 4, k) = global_connection {
					connection_exists = true;
					break;
				}
			}
		
			//if connection doesn't exist, add connection
			if !connection_exists {
				var _height = ds_grid_height(connections);
				ds_grid_resize(connections, 7, _height+1);
				ds_grid_set(connections, 0, _height, node_1); //in node
				ds_grid_set(connections, 1, _height, node_2); //out node
				ds_grid_set(connections, 2, _height, ds_grid_get(nodes, 2, node_1)); //layer
				ds_grid_set(connections, 3, _height, random_range(-1, 1)); //connection weight
				ds_grid_set(connections, 4, _height, global_connection); //connection number for breeding
				ds_grid_set(connections, 5, _height, 0); //disabled (0 n, 1 y)
				ds_grid_set(connections, 6, _height, ds_grid_get(nodes, 2, node_2)); //out layer
			
				show_debug_message("Connection Created between: " + string(node_1) + " and " + string(node_2));
				exit;
			} else {
				show_debug_message("Connection Already Exists between: " + string(node_1) + " and " + string(node_2));
			}
		}
	}
}