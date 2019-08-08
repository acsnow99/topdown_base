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



with (instance_nearest(x, y, obj_pain)) {
	if (place_meeting(x, y, other) and not other.knockback) {
		if (other.vulnerable) {
			//moved the knockback code below
			//so knockback happens whenever the player hits a damaging thing, even during vulnerability
			health -= damage;
			
			other.current_attacker = id;
			other.vulnerable = false;
			other.alarmvar_attacked = global.gametime + 0.79;
		}
		else {
			other.alarmvar_attacked_while_invulnerable = other.alarmvar_attacked;
		}
		
		//set the knockback angle preemptively to prevent jank
		other.knockback_angle = point_direction(x, y, other.x, other.y);
		
		other.knockback = true;
		
		//set the knockback angle differently if the player is dashing at an angle
		if (other.dashing and (other.dash_direction == "up_right" or other.dash_direction == "left_up" or other.dash_direction == "down_left" or other.dash_direction == "right_down")) {
			for (var i = 0; i < array_length_1d(other.movement_inputs); i++) {
				if (other.dash_direction == other.movement_inputs[i]) {
					if ((other.dash_direction == "up_right" and other.knockback_angle >= up_right_angle) or (other.dash_direction == "left_up" and (other.knockback_angle >= left_up_angle or other.knockback_angle <= 90))  or (other.dash_direction == "down_left" and other.knockback_angle >= down_left_angle and other.knockback_angle <= 180)  or (other.dash_direction == "right_down" and other.knockback_angle >= right_down_angle)) {
						other.knockback_angle = other.directions[i] - 90;
					}
					else {
						other.knockback_angle = other.directions[i] + 90;
					}
				}
			} 
		}
		
	}
}
#endregion