var move_speed_current = move_speed * global.dt_steady;

walking = (alarmvar_movement >= global.gametime + 1)

//this runs for half of the alarm
if (walking) {
	
	if (seed < 1 and seed >= 0) {
		var move_direction = 0;
	}
	else if (seed < 2 and seed >= 1) {
		var move_direction = 90;
	}
	else if (seed < 3 and seed >= 2) {
		var move_direction = 180;
	}
	else if (seed < 4 and seed >= 3) {
		var move_direction = 270;
	}
	
	scr_move(move_speed_current, move_direction);
	
}

//nothing runs for the second half of the alarm;
//at the end of the alarm, the seed and alarm are reset
else if (alarmvar_movement <= global.gametime) {
	
	//random seed to make a 1 in 4 chance of the enemy moving in each direction
	seed = random(4);
	
	alarmvar_movement = global.gametime + 2;
}