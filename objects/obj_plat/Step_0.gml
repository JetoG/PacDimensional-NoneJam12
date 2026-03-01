if (global.mundo and image_index == 1) {
    sprite_index = spr_plat;
    mask_index   = spr_plat;
} else if (global.mundo and image_index == 0) {
    sprite_index = spr_noone;
    mask_index   = spr_noone;
} else if (!global.mundo and image_index == 1) {
    sprite_index = spr_noone;
    mask_index   = spr_noone;
} else if (!global.mundo and image_index == 0) {
    sprite_index = spr_plat;
    mask_index   = spr_plat;
}

if (instance_exists(obj_player)) {
    if (place_meeting(x, y, obj_player)) {
        with (obj_player) {
        	y--;
        }
    }
}
