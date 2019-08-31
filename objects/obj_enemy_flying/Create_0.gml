//higher number means taller than it is wide
up_right_angle = 225;
//higher number means wider than it is tall
left_up_angle = 315;
//higher number means taller than it is wide
down_left_angle = 45;
//higher number means wider than it is tall
right_down_angle = 135;

damage = 0;
move_speed = 350;

//random seed to make a 1 in 4 chance of the enemy moving in each direction; 
//resets every rotation through the alarm
seed = random(5);
alarmvar_movement = global.gametime+ 1.5;
move = false;
walking = true;
crossed_border = false;

animation_alarm_walking = global.gametime + 0.2;