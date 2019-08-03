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
	
	obj_camera.alarm_variable1 = global.gametime + 0.01;
	
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



with (current_attacker) {
	if (place_meeting(x, y, other) and other.vulnerable) {
		other.current_attacker = id;
		other.vulnerable = false;
		other.knockback = true;
		other.alarmvar_attacked = global.gametime + 0.79;
		
		health -= damage;
	
		//set the knockback angle preemptively to prevent jank
		other.knockback_angle = point_direction(x, y, other.x, other.y);
	}
}

#endregion