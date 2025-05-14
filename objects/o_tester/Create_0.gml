input_number = irandom_range(5, 10);
total_layers = irandom_range(2, 5);

test = ds_grid_create(input_number, input_number);
for (var i = 0; i < input_number; i++) {
	ds_grid_set_region(test, i, 0, i, input_number-1, irandom(3));
}

test_weight = ds_grid_create(input_number * total_layers, input_number);

for (var i = 0; i < input_number * total_layers; i++) {
	for (var j = 0; j < input_number; j++) {
		ds_grid_set(test_weight, i, j, random_range(-2, 2));
	}
}

test_inter = ds_grid_create(input_number, input_number);

for (var i = 0; i < total_layers; i++) {
	ds_grid_set_grid_region(test_inter, test_weight, i * input_number, 0, i * input_number + input_number-1, input_number-1, 0, 0);
	
	ds_grid_multiply_grid_region(test_inter, test, 0, 0, input_number-1, input_number-1, 0, 0);
	
	for (var j = 0; j < input_number; j++) {
		ds_grid_set_region(test, j, 0, j, input_number-1, ds_grid_get_sum(test_inter, 0, j, input_number-1, j));
	}
}