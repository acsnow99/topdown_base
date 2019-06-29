/// Checks/calculations that happen every step
#region code from online(buttery smooth movement tutorial)
var move_speed_current = move_speed * global.dt_steady;

var move_xinput = 0;
var move_yinput = 0;
#endregion


#region Check if they want to move
if (room_change == false and immovable == false){ //if they aren't going through a door or a stairwell or using an item
	#region code from online(buttery smooth movement tutorial)
	for (var i = 0; i < array_length_1d(movement_inputs); i++) {
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
else if (alarmvar_rightside > 0) { //move in a certain direction if they just entered a room
	alarmvar_rightside--
	x -= 2;
}
else if (alarmvar_leftside > 0) {
	alarmvar_leftside--
	x += 2;
}
else if (alarmvar_bottomside > 0) {
	alarmvar_bottomside--
	y -= 2;
}
else if (alarmvar_topside > 0) {
	alarmvar_topside--
	y += 2;
}
else if alarm1_activated == false { //only activates the alarm effect once, so room_change isn't permanently false
	room_change = false;
	alarm1_activated = true;
}

#endregion

if (alarmvar_roomchange <= global.gametime) {
	room_change = false;
	alarmvar_roomchange += 50000000000000000000;
}

//auto-heal
if (health <= 100) {
	health += 0.1;
}

if (keyboard_check(vk_control)) {
	health = 0;
}

//set the spawn point when touching a pit boundary object
with (instance_nearest(x, y, obj_spawnpoint_pit)) {
	if (place_meeting(x, y, obj_player) and not other.jumping and not other.pitfall) {
		other.spawnx_pit = x;
		other.spawny_pit = y;
	}
}

//player will get dragged into pits if they are too close and aren't jumping
if (distance_to_object(obj_pit) <= 25 and not jumping) {
	
	x = lerp(x, instance_nearest(x, y, obj_pit).x, pitfall_spd);
	y = lerp(y, instance_nearest(x, y, obj_pit).y, pitfall_spd);
	pitfall_spd += 0.00085;
			
	if (instance_exists(obj_pit_bottomless) 
		and x <= instance_nearest(x, y, obj_pit_bottomless).x + 12 and x >= instance_nearest(x, y, obj_pit_bottomless).x - 12 
		and y <= instance_nearest(x, y, obj_pit_bottomless).y + 12 and y >= instance_nearest(x, y, obj_pit_bottomless).y - 12
		and not jumping) {
			x = spawnx_pit;
			y = spawny_pit;
			
			health -= 10;
	}
	else if (instance_exists(obj_pit_bottomful)
		and x <= instance_nearest(x, y, obj_pit_bottomful).x + 12 and x >= instance_nearest(x, y, obj_pit_bottomful).x - 12 
		and y <= instance_nearest(x, y, obj_pit_bottomful).y + 12 and y >= instance_nearest(x, y, obj_pit_bottomful).y - 12
		and not jumping and not room_change) {
			if not instance_exists(obj_fadeout) and not instance_exists(obj_fadein){ //fade effect
				instance_create_layer(0,0,"ForegroundFX",obj_fadeout);
			}
			alarmvar_roomchange = 60; //wait 60 steps before telling the camera to move normally again
			alarm2_activated = false;
	
			global.playerx = x;
			global.playery = y;
	
			room_coming = room_basement;
			alarm_var2 = global.gametime + 30*1000
	
			room_change = true;
			global.rooms_passed += 1;
	}
}

if (distance_to_object(obj_pit) > 25) {
	pitfall = false;
	pitfall_spd = 0.075;
}

for (var i = 59; i > 0; --i) {
	xlist[i] = xlist[i-1];
	ylist[i] = ylist[i-1];
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
	alarm_var2 += 50000000000000000000;
}