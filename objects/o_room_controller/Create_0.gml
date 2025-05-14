randomize();

global.connections = ds_grid_create(3, 0);

repeat (100) {
	instance_create_layer(x, y, "Instances", o_neat_controller);
}

wait = 0;