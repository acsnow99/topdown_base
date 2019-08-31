var move_speed_current = move_speed * global.dt_steady;

walking = (alarmvar_movement >= global.gametime + 0.75)

if ((x < room_width - 128) and (y > 128) and (x > 128) and (y < room_height - 128) and not place_meeting(x, y, obj_wall_parent) and not place_meeting(x, y, obj_pain)) {
	var crossed_border = false;
}
else {
	var crossed_border = true;
}

//this runs for half of the alarm
if (walking) {
	
	//1/5 chance to move in each of 4 directions, 
	//1/5 chance to stay still
	//will move away from borders of room
	if ((seed < 3 and seed >= 2) or (seed < 2 and seed >= 1)) {
		if (not move) {
			move_direction = -move_speed_current;
		}
	}
	else if (not move) {
		move_direction = move_speed_current;
	}



	if (crossed_border) {
		move_direction = -move_direction;
	}
	
	if ((seed < 1 and seed >= 0) or (seed < 3 and seed >= 2)) {
		x += move_direction;
	}
	if ((seed < 2 and seed >= 1) or (seed < 4 and seed >= 3)) {
		y += move_direction;
	}
	
	move = true;
}

//nothing runs for the second half of the alarm;
//at the end of the alarm, the seed and alarm are reset
else if (alarmvar_movement <= global.gametime) {
	
	//random seed to make a 1 in 4 chance of the enemy moving in each direction
	seed = random(5);
	
	move = false;
	alarmvar_movement = global.gametime + 1.5;
}