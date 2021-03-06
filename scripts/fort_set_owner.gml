///fort_set_owner(fort_instance, player_number)
/*
* Set owner of the fort. Changes the owner variable and the sprite of the arc.
*/

// Games Programming Assignment 1
// Add game feature:   Fort spawning
// Student Number:     S10122326F
// Student Name:       Jeremy Lim

var fort_instance = argument0;
var player_number = argument1;

fort_instance.owner = player_number;
if (fort_instance.owner == PLAYER_ONE) {
    fort_instance.arc.sprite_index = fort_scan_arc_sprite;
}
else {
    fort_instance.arc.sprite_index = fort_scan_arc_sprite2;
}