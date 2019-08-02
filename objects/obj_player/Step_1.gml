//self-destruct button
if (keyboard_check(vk_control)) {
	health = 0;
}

//death protocol
if (health <= 0) {
	x = -1;
	y = -1;
	ded = true;
	room_change = true;
	alarmvar_roomchange = global.gametime + 0.1;
	
	obj_camera.alarm_variable1 = 1;
	
	//try to implement a fade out function at death
	//instance_create_layer(0,0, "Walls", obj_fadeout);
}
else {
	ded = false;
}

#region state changes

if (keyboard_check_pressed(vk_space) and not pitfall) {
	dash_setup = true;
	alarmvar_dash_setup = global.gametime + 0.2;
}

#endregion