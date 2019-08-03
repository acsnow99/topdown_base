/// Checks/calculations that happen every step


//reset current input for next dash every step(dash goes in most recently inputted direction
if (not dashing) {
	for (var i = 0; i < 4; i++) {
		if (i == 3) {
			var other_input = 0;
		}
		else {
			var other_input = i + 1;
		}
		if (keyboard_check(movement_inputs[i])) {
			if (keyboard_check(movement_inputs[other_input])) {
				dash_direction = movement_inputs[i+4];
				break;
			}
			else {
				dash_direction = movement_inputs[i];
			}
		}
	}
}


#region code from online(buttery smooth movement tutorial)
var move_speed_current = move_speed * global.dt_steady;

var move_xinput = 0;
var move_yinput = 0;
#endregion

#region dash
if (dash_setup and alarmvar_dash_setup <= global.gametime) {
	dash_setup = false;
	dashing = true;
	alarmvar_dash = global.gametime + 0.075;
	alarmvar_dash_setup = global.gametime + 500000000000;
}
if (dashing and alarmvar_dash <= global.gametime and not knockback) {
	if (instance_exists(obj_pit_bottomless_edge) and distance_to_object(obj_pit_bottomless_edge) <= 100) {
		pitfall = true;
	}
	dashing = false;
	alarmvar_dash = global.gametime + 500000000000;
	lag = true;
	alarmvar_lag = global.gametime + 0.07;
}

if (dashing and not knockback) {
	for (var i = 0; i < array_length_1d(movement_inputs); i++) {
		if (dash_direction == movement_inputs[i]) {
			var dash_angle = directions[i];
		}
	} 
	scr_move(move_speed_current * 12, dash_angle);
}
#endregion


#region Check if they want to move
if (not room_change and not immovable and not lag and not dash_setup and not dashing){ //if they aren't going through a door or a stairwell or using an item
	#region code from online(buttery smooth movement tutorial)
	for (var i = 0; i < 4; i++) {
		var this_key = movement_inputs[i];
		if keyboard_check(this_key) {
			var this_angle = i * 90;
			move_xinput += lengthdir_x(1, this_angle);
			move_yinput += lengthdir_y(1, this_angle);
		}
	}
	
	var moving = (point_distance(0, 0, move_xinput, move_yinput) > 0);
	if moving {
		var move_dir = point_direction(0, 0, move_xinput, move_yinput);
		scr_move(move_speed_current, move_dir);
	}
	#endregion
}
else if (alarmvar_rightside > global.gametime) { //move in a certain direction if they just entered a room
	x -= 360 * global.dt_steady;
}
else if (alarmvar_leftside > global.gametime) {
	x += 360 * global.dt_steady;
}
else if (alarmvar_bottomside > global.gametime) {
	y -= 360 * global.dt_steady;
}
else if (alarmvar_topside > global.gametime) {
	y += 360 * global.dt_steady;
}
else if alarm1_activated == false { //only activates the alarm effect once, so room_change isn't permanently false
	room_change = false;
	alarm1_activated = true;
}


#region what happens when you get damaged
if (knockback) {
	if dashing {
		var stop_knockback = 0.7;
	}
	else {
		var stop_knockback = 0.75;
	}
	
	//get knocked back at the angle calculated at the time of getting hit(begin step)
	scr_move(move_speed_current * 10, knockback_angle);
	
	if (alarmvar_attacked <= global.gametime + stop_knockback and not place_meeting(x, y, current_attacker)) {
		knockback = false;
	}
}
else if (alarmvar_attacked <= global.gametime) {
	vulnerable = true;
	alarmvar_attacked = global.gametime + 500000000000;
}

#endregion

if (alarmvar_roomchange <= global.gametime) {
	room_change = false;
	alarmvar_roomchange += 50000000000000000000;
}
#endregion

//auto-heal
/*if (health <= 100) {
	health += 0.1;
}*/


//player will get dragged into pits if they are too close and aren't dashing
if (instance_exists(obj_pit_bottomless_edge) and distance_to_object(obj_pit_bottomless_edge) <= 100 and not dashing) {
	x = lerp(x, instance_nearest(x, y, obj_pit_bottomless_edge).x, pitfall_spd);
	y = lerp(y, instance_nearest(x, y, obj_pit_bottomless_edge).y, pitfall_spd);
	pitfall_spd += 0.005;
			
	if (instance_exists(obj_pit_bottomless_edge) 
		and x <= instance_nearest(x, y, obj_pit_bottomless_edge).x + 12 and x >= instance_nearest(x, y, obj_pit_bottomless_edge).x - 12 
		and y <= instance_nearest(x, y, obj_pit_bottomless_edge).y + 12 and y >= instance_nearest(x, y, obj_pit_bottomless_edge).y - 12
		and not dashing) {
			
			//stop trying to dash if falling in a pit
			if (dash_setup) {
				dash_setup = false;
				alarmvar_dash_setup = global.gametime + 500000000000;
			}
			
			x = spawnx_pit;
			y = spawny_pit;
			
			vulnerable = false;
			alarmvar_attacked = global.gametime + 0.75;
			
			health -= 10;
	}
}
//pits in the center of a larger pit will make the player fall in at contact(no pull-in effect)
if (place_meeting(x, y, obj_pit_bottomless_center) and not dashing) {
	x = spawnx_pit;
	y = spawny_pit;
	
	vulnerable = false;
	alarmvar_attacked = global.gametime + 0.75;
	
	health -= 10;
}
//reset pitfall settings when the player is far enough away from a pit(not touching)
if (distance_to_object(obj_pit) > 100) {
	pitfall = false;
	pitfall_spd = 0.025;
}
//set the spawn point when touching a pit boundary object
with (instance_nearest(x, y, obj_spawnpoint_pit)) {
	if (place_meeting(x, y, obj_player) and not other.dashing and not other.pitfall) {
		other.spawnx_pit = x;
		other.spawny_pit = y;
	}
}


if (alarm_var2 <= global.gametime) {
	room_goto(room_coming);
	/*
	if room_coming == 0 {
		room_goto(room_explore);
	}
	else if room_coming == 1 {
		room_goto(room_exploreAgain);
	}
	else if room_coming == 2 {
		room_goto(room_exploreAThirdTime);
	}
	else if room_coming == 3 {
		room_goto(room_basement);
	}*/
	alarm_var2 += global.gametime + 500000000000000;
}

//lag reset timer
if (alarmvar_lag <= global.gametime) {
	lag = false;
	alarmvar_lag = global.gametime + 5000000000;
}