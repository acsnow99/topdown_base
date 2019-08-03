if (not vulnerable) {
	image_index = 2;
}
else {
	image_index = 0;
}
draw_sprite(spr_exploreblock, image_index, x, y);

draw_text(camera_get_view_x(view) + 50, camera_get_view_y(view) + 50, health);