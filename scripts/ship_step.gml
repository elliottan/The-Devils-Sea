// Games Programming Assignment 1
// Add game feature:   Ship movement, ship death animation, Xebec passive ability
// Student Number:     S10122326F
// Student Name:       Jeremy Lim

// Add game feature:   Ship abilities
// Student Number:     S10131808A
// Student Name:       Elliot Tan

// keep object below global max speed
if(speed > SHIP_MAX_SPEED * SHIP_SPEED_MULTIPLIER)
    speed = SHIP_MAX_SPEED * SHIP_SPEED_MULTIPLIER;
    
// limit maximum speed
if (speed > max_speed){
    speed -= 100 * SHIP_SPEED_MULTIPLIER / room_speed;
}

// moving sound
audio_pause_sound(engine_sound);
if (speed > 0) {
    audio_resume_sound(self.move_sound);
    audio_sound_gain(self.move_sound,
        self.speed / (SHIP_MAX_SPEED * SHIP_SPEED_MULTIPLIER),
        audio_sound_get_track_position(self.move_sound));
}
else
    audio_pause_sound(self.move_sound);

// Xebec passive ability: more speed when heading towards other ship
if(ship_type == SHIP_XEBEC) {
    if (instance_exists(other_ship)) {
        if(angle_difference(image_angle, point_direction(x, y, other_ship.x, other_ship.y)) > -45
            || angle_difference(image_angle, point_direction(x, y, other_ship.x, other_ship.y)) < 45)
            var isFacingOther = true;
        else var isFacingOther = false;
        
        if(isFacingOther && !xebec_passive){
            max_speed += 10 * SHIP_SPEED_MULTIPLIER;
            xebec_passive = true;
        }else if(!isFacingOther && xebec_passive){
            max_speed -= 10 * SHIP_SPEED_MULTIPLIER;
            xebec_passive = false;
        }
    }
}

// death animation
if(hp <= 0) {
    speed = 0;
    max_speed = 1;
    acceleration = 1;
    turn_speed = 1;
    mass = 1;
    collidable = false;
    traps = 0;
    image_angle += 5;
    image_xscale = image_xscale * 0.99;
    image_yscale = image_yscale * 0.99;
}

// Add game feature:   Ship ability and powerup timers
// Student Number:     S10131808A
// Student Name:       Elliot Tan

// boost time updates
if (rum_boost_time > 0) {
    rum_boost_time--;
}
if (divine_boost_time > 0) {
    divine_boost_time--;
    
    // move shield graphic
    divine_boost_shield.x = self.x;
    divine_boost_shield.y = self.y;
}
    
// if boost time reaches 0, set it to -1 flag
if (rum_boost_time == 0) {
    ship_reset_boost();
    rum_boost_time = -1;
}
if (divine_boost_time == 0) {
    divine_boost_time = -1;
    
    // destroy divine boost shield
    with (divine_boost_shield) {
        instance_destroy();
    }
    
    stop_shield_sound();
}

// ulti time update
if (ulti_countdown > 0)
    ulti_countdown--;
if (ulti_timer > 0)
    ulti_timer--;
    
// end ulti timer
if (ulti_timer == 0) {
    ulti_timer = -1;
    if(ship_type == SHIP_XEBEC)
        xebec_ulti_deactivate();
}

// movement animation
var player_color = make_color_rgb(22, 190, 254);
if (owner == PLAYER_TWO) player_color = make_color_rgb(255, 128, 128);

if (rum_boost_time > 0) {
    effect_create_below(ef_firework,
        x - cos(degtorad(image_angle)) * sprite_width * 0.2,
        y + sin(degtorad(image_angle)) * sprite_width * 0.2,
        0, player_color);
}
else if (speed > 0) {
    effect_create_below(ef_flare,
        x - cos(degtorad(image_angle)) * sprite_width * 0.2,
        y + sin(degtorad(image_angle)) * sprite_width * 0.2,
        0, player_color);
}

// help text
if (instance_exists(help_text)) {
    help_text.x = x;
    help_text.y = y - 50;
}