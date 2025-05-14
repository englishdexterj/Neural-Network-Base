for (var i = 0; i < input_number; i++) {
	ds_grid_set_region(test, i, 0, i, input_number-1, irandom(3));
}

for (var i = 0; i < total_layers; i++) {
	ds_grid_set_grid_region(test_inter, test_weight, i * input_number, 0, i * input_number + input_number-1, input_number-1, 0, 0);
	
	ds_grid_multiply_grid_region(test_inter, test, 0, 0, input_number-1, input_number-1, 0, 0);
	
	for (var j = 0; j < input_number; j++) {
		ds_grid_set_region(test, j, 0, j, input_number-1, ds_grid_get_sum(test_inter, 0, j, input_number-1, j));
	}
}