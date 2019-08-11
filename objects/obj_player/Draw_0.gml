for (var i = 0; i < 8; i++) {
	if (dash_direction == movement_inputs[i]) {
		image_index = i;
	}
}
if (not vulnerable) {
	image_index += 8;
}

if (not dashing) {
	draw_sprite(spr_playeridle_dev, image_index, x, y);
}
else {
	if (animation_frame_dash > 5) {
		animation_frame_dash = 0;
	}
	if (animation_alarm_dash <= global.gametime) {
		animation_frame_dash++;
		animation_alarm_dash = global.gametime + 0.05;
	}
	
	image_index += animation_frame_dash * 4;
	draw_sprite(spr_playerdash_dev, image_index, x, y);
}

draw_text(camera_get_view_x(view) + 50, camera_get_view_y(view) + 50, health);