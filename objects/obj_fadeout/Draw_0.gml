draw_set_color(c_white);
draw_set_alpha(1-(variable_timer/30));
draw_rectangle(camera_get_view_x(view),camera_get_view_y(view),camera_get_view_x(view)+7680/3,camera_get_view_y(view)+4320/3,false);
draw_set_alpha(1);