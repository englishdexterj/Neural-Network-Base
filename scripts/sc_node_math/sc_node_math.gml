// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sc_node_math(math_type, value) {
	switch math_type {
		case 0:
			break;
		case 1: //Sigmoid
			value = 1/(1+power(2.7,-value));
			break;
		case 2: //Tanh
			value = 2/(1+power(2.7,-2*value))-1;
			break;
		case 3: //ReLU 1
			value = max(0, value);
			break;
		case 4: //ReLU 2
			if (value >= 0) value = 1;
			else value = 0;
			break;
		case 5: //Leaky ReLU
			if (value < 0) value *= .01;
			break;
		case 6: //Swish
			value = value/(1-power(2.7,-value));
			break;
		default:
			show_debug_message("No Math Type Available")
			break;
	}
	
	return value;
}