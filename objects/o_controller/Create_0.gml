randomize();

repeat(1000) {
	instance_create_layer(x, y, "Instances", o_tester);
}

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

#region test
if 1 = 2 {
input_number = 3;
total_layers = 2;
	
test = ds_grid_create(3, 3);
ds_grid_set_region(test, 0, 0, 0, 2, 4);
ds_grid_set_region(test, 1, 0, 1, 2, 2);
ds_grid_set_region(test, 2, 0, 2, 2, 1);

test_weight = ds_grid_create(6, 3);

ds_grid_set(test_weight, 0, 0, 2);
ds_grid_set(test_weight, 0, 1, 3);
ds_grid_set(test_weight, 0, 2, 3);

ds_grid_set(test_weight, 1, 0, 4);
ds_grid_set(test_weight, 1, 1, 1);
ds_grid_set(test_weight, 1, 2, 2);

ds_grid_set(test_weight, 2, 0, 2);
ds_grid_set(test_weight, 2, 1, 3);
ds_grid_set(test_weight, 2, 2, 1);

ds_grid_set(test_weight, 3, 0, 1);
ds_grid_set(test_weight, 3, 1, 3);
ds_grid_set(test_weight, 3, 2, 4);

ds_grid_set(test_weight, 4, 0, 4);
ds_grid_set(test_weight, 4, 1, 2);
ds_grid_set(test_weight, 4, 2, 2);

ds_grid_set(test_weight, 5, 0, 3);
ds_grid_set(test_weight, 5, 1, 1);
ds_grid_set(test_weight, 5, 2, 3);
}
#endregion

test_inter = ds_grid_create(input_number, input_number);

show_debug_message("\nValues");
for (var i = 0; i < ds_grid_height(test); i++) {
	var line = "";
	for (var j = 0; j < ds_grid_width(test); j++) {
		line = line + " " + string(ds_grid_get(test, j, i))
	}
	show_debug_message(line);
}

for (var i = 0; i < total_layers; i++) {
	ds_grid_set_grid_region(test_inter, test_weight, i * input_number, 0, i * input_number + input_number-1, input_number-1, 0, 0);
	
	ds_grid_multiply_grid_region(test_inter, test, 0, 0, input_number-1, input_number-1, 0, 0);
	
	for (var j = 0; j < input_number; j++) {
		ds_grid_set_region(test, j, 0, j, input_number-1, ds_grid_get_sum(test_inter, 0, j, input_number-1, j));
	}
	
	show_debug_message("\nValues");
	for (var ii = 0; ii < ds_grid_height(test); ii++) {
		var line = "";
		for (var j = 0; j < ds_grid_width(test); j++) {
			line = line + " " + string(ds_grid_get(test, j, ii))
		}
		show_debug_message(line);
	}
}

show_debug_message("\nInter");
for (var i = 0; i < ds_grid_height(test_inter); i++) {
	var line = "";
	for (var j = 0; j < ds_grid_width(test_inter); j++) {
		line = line + " " + string(ds_grid_get(test_inter, j, i))
	}
	show_debug_message(line);
}

show_debug_message("\nWeights");
for (var i = 0; i < ds_grid_height(test_weight); i++) {
	var line = "";
	for (var j = 0; j < ds_grid_width(test_weight); j++) {
		line = line + " " + string(ds_grid_get(test_weight, j, i))
	}
	show_debug_message(line);
}