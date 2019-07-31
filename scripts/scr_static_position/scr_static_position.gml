var right = false, up = false, left = false, down = false
if (instance_position(x+256, y, argument0)) {
	right = true;
}
if (instance_position(x, y-256, argument0)) {
	up = true;
}
if (instance_position(x-256, y, argument0)) {
	left = true;
}
if (instance_position(x, y+256, argument0)) {
	down = true;
}

if (right and up and left and down) {
	instance_create_layer(x, y, "Instances", argument1);
}
else {
	instance_create_layer(x, y, "Instances", argument2);
}