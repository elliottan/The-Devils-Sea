// Games Programming Assignment 1
// Add game feature:   Fort spawning
// Student Number:     S10122326F
// Student Name:       Jeremy Lim

/*
* Create an arc object and link it to the fort.
* The arc shall have no variables, opting instead to use
* the fort's variables for calculation.
*/
arc = instance_create(x, y, fort_scan_arc_obj);
arc.image_angle = random_range(0, 360);
arc.fort = id;
arc.ulti = false;

targetAcquired = false;
targetAngle = 0;
attack_timer = 0;
owner = 0;

// create fort radius object for collision detection with ships
// ships that collide are "in-range" for capturing a fort
radius = instance_create(x, y, fort_radius_obj);
radius.image_xscale = fort_scan_arc_obj.sprite_width * 2 / radius.sprite_width;
radius.image_yscale = fort_scan_arc_obj.sprite_width * 2 / radius.sprite_height;
radius.fort = id;

// initialize timer flag to 5 seconds
capture_timer = room_speed * 5;
blue_bar = instance_create(x, y, blue_bar_obj);
blue_bar.visible = false;
red_bar = instance_create(x, y, red_bar_obj);
red_bar.visible = false;
