//trigger to go to the second frame of the animation; 
//only activates in the walking phase of the loop
if (animation_alarm_walking <= global.gametime and walking) {
	if (image_index == 0) {
		image_index++;
	}
	else {
		image_index--;
	}
	animation_alarm_walking = global.gametime + 0.1;
}


draw_sprite(spr_enemy_dev1_fly, image_index, x, y);

//appears higher above other objects as they go down they screen
if (y != yprevious) {
	depth = -y;
}