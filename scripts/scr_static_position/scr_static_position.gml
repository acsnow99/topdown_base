var right = false, up = false, left = false, down = false
if (instance_position(x+256, y, argument0) or instance_position(x+130, y, obj_wall_parent)) {
	right = true;
}
if (instance_position(x, y-256, argument0) or instance_position(x, y-130, obj_wall_parent)) {
	up = true;
}
if (instance_position(x-256, y, argument0) or instance_position(x-130, y, obj_wall_parent)) {
	left = true;
}
if (instance_position(x, y+256, argument0) or instance_position(x, y+130, obj_wall_parent)) {
	down = true;
}

if (right and up and left and down) {
	instance_create_layer(x, y, "Instances", argument1);
}
else {
	instance_create_layer(x, y, "BackgroundFX", argument2);
	if (not right) {
		if (not instance_position(x+256, y, argument3)) {
			instance_create_layer(x+256, y, "BackgroundFX", argument3);
		}
	}
	if (not up) {
		if (not instance_position(x, y-256, argument3)) {
			instance_create_layer(x, y-256, "BackgroundFX", argument3);
		}
	}
	if (not left) {
		if (not instance_position(x-256, y, argument3)) {
			instance_create_layer(x-256, y, "BackgroundFX", argument3);
		}
	}
	if (not down) {
		if (not instance_position(x, y+256, argument3)) {
			instance_create_layer(x, y+256, "BackgroundFX", argument3);
		}
	}
}
