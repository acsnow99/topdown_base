if not instance_exists(obj_fadeout) and not instance_exists(obj_fadein){ //fade effect
	instance_create_layer(0,0,"ForegroundFX",obj_fadeout);
}

if (room_change == false) {
	if (x < 0) {
		//leaving through the left door of a room
		alarmvar_rightside = global.gametime + 1; //wait 60 steps before telling the camera to move normally again
		alarm1_activated = false;
	
		global.playerx = 2825;
		if (room == 0) {
			global.playery = 900;
			room_coming = room_exploreAgain;
		}
	}
	if (x >= 2800) {
		//leaving through the right door of a room
		alarmvar_leftside = global.gametime + 1; //wait 60 steps before telling the camera to move normally again
		alarm1_activated = false;
	
		global.playerx = -25;
		if (room == 1) {
			global.playery = 1100;
			room_coming = room_explore;
		}	
	}
	if (y < 0) {
		//leaving through the top door of a room
		alarmvar_bottomside = global.gametime + 1; //wait 60 steps before telling the camera to move normally again
		alarm1_activated = false;
	
		global.playery = 2025;
		if (room == 0) {
			global.playerx = 1720;
			room_coming = room_exploreAThirdTime;
		}
	}
	if (y > 2000) {
		//leaving through the bottom door of a room
		alarmvar_topside = global.gametime + 1; //wait 60 steps before telling the camera to move normally again
		alarm1_activated = false;
	
		global.playery = -25;
		if (room == 2) {
			global.playerx = 1280;
			room_coming = room_explore;
		}
	}
	alarm_var2 = global.gametime + 0.5; //waits a half second to move to the next room
}

room_change = true;
global.rooms_passed += 1;

