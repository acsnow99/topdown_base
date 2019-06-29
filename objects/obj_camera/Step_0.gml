if (obj_player.room_change == true){
	if (alarm_variable1 <= global.gametime){
		room_change = true;
		alarm_variable1 = global.gametime + 0.5;
	}
}
else{
	room_change = false;
	alarm_variable1 = global.gametime + 0.5;
}
