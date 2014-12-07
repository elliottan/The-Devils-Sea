if (!other.collidable) exit;

// get size of cannonball (0 - small, 1 - medium)
var size = argument0;

// create smoke effect
effect_create_above(ef_smoke, self.x, self.y, size+1, c_black);

// destroy cannonball
instance_destroy();
