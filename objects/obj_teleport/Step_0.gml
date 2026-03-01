if (image_index == 6) {
    global.mundo = !global.mundo; 
    layer_set_visible(layer_get_id("Sombrio"), global.mundo);
    layer_set_visible(layer_get_id("SombrioExtras"), global.mundo);
    layer_set_visible(layer_get_id("BgSombrio"), global.mundo);
    layer_set_visible(layer_get_id("BgSombrioParallax"), global.mundo);
    layer_set_visible(layer_get_id("Normal"), !global.mundo);
    layer_set_visible(layer_get_id("NormalExtras"), !global.mundo);
    layer_set_visible(layer_get_id("BgNormal"), !global.mundo);
}

if (instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y - (sprite_get_height(spr_player_idle) / 2);
}