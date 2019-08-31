var move_speed_current = move_speed * global.dt_steady;

walking = (alarmvar_movement >= global.gametime + 1)

//this runs for half of the alarm
if (walking) {
	
	var move = true;
	
	//1/5 chance to move in each of 4 directions, 
	//1/5 chance to stay still
	//will move away from borders of room
	if (seed < 1 and seed >= 0) {
		if (x < room_width - 128 and not crossed_border) {
			var move_direction = 0;
		}
		else {
			//if the enemy hits the edge of the room, it will reverse direction;
			//crossed_border keeps it from resetting its direction towards the border
			var move_direction = 180;
			crossed_border = true;
		}
	}
	else if (seed < 2 and seed >= 1) {
		if (y > 128 and not crossed_border) {
			var move_direction = 90;
		}
		else {
			var move_direction = 270;
			crossed_border = true;
		}
	}
	else if (seed < 3 and seed >= 2) {
		if (x > 128 and not crossed_border) {
			var move_direction = 180;
		}
		else {
			var move_direction = 0;
			crossed_border = true;
		}
	}
	else if (seed < 4 and seed >= 3) {
		if (y < room_height - 128 and not crossed_border) {
			var move_direction = 270;
		}
		else {
			var move_direction = 90;
			crossed_border = true;
		}
	}
	else if (seed < 5 and seed >= 4) {
		move = false;
	}
	else {
		move = false;
	}
	
	if (move) {
		scr_move_detect_obstacles(move_speed_current, move_direction);
	}
	
}

//nothing runs for the second half of the alarm;
//at the end of the alarm, the seed and alarm are reset
else if (alarmvar_movement <= global.gametime) {
	
	//random seed to make a 1 in 4 chance of the enemy moving in each direction
	seed = random(5);
	
	crossed_border = false;
	alarmvar_movement = global.gametime + 2;
}