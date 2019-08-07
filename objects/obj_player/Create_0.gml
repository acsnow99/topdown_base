dashing = false;
dash_setup = false;
room_change = false;
immovable = false;
move_speed = 400;
lag = false;
ded = false;
vulnerable = true;
knockback = false;

pitfall_spd = 0.025;
pitfall = false;
spawnx_pit = x;
spawny_pit = y;

//current_attacker = instance_nearest(x, y, obj_pain);
knockback_angle = 0;

alarmvar_rightside = 0;
alarmvar_leftside = 0;
alarmvar_bottomside = 0;
alarmvar_topside = 0;
alarmvar_roomchange = 0;
alarmvar_dash_setup = 0;
alarmvar_dash = 0;
alarmvar_lag = 0;
alarmvar_attacked = 0;
alarmvar_attacked_while_invulnerable = 0;
alarm1_activated = false;
alarm_var2 = 5000000000000000;

room_coming = 0;

movement_inputs[0] = vk_right;
movement_inputs[1] = vk_up;
movement_inputs[2] = vk_left;
movement_inputs[3] = vk_down;
movement_inputs[4] = "up_right";
movement_inputs[5] = "left_up";
movement_inputs[6] = "down_left";
movement_inputs[7] = "right_down";
directions[0] = 0;
directions[1] = 90;
directions[2] = 180;
directions[3] = 270;
directions[4] = 45;
directions[5] = 135;
directions[6] = 225;
directions[7] = 315;
dash_direction = vk_right;

health = 100;