cargas_inicial = 0;
cargas   = 0;
cargas_d = cargas;
cargas_g = cargas;

draw_loads = function () {
    draw_self();
    
    var _spr_w = sprite_get_width(spr_hud_load);
    var _spr_h = sprite_get_height(spr_hud_load);
    
    var _x = x + 19;
    var _y = y + 3;
    
    // --- ALTURAS ---
    var _ld_main  = (cargas_d / cargas_inicial) * _spr_h;
    var _ld_ghost = (cargas_g / cargas_inicial) * _spr_h;
    
    // --- GHOST ---
    var _yy_g = _spr_h - _ld_ghost;
    var _dy_g = _y + (_spr_h - _ld_ghost);
     
    draw_sprite_part_ext(spr_hud_load, 1, 0, _yy_g, _spr_w, _ld_ghost, _x, _dy_g, 1, 1, c_white, 0.4);
    
    // --- BARRA PRINCIPAL ---
    var _yy = _spr_h - _ld_main;
    var _dy = _y + (_spr_h - _ld_main);

    draw_sprite_part_ext(spr_hud_load, 1, 0, _yy, _spr_w, _ld_main, _x, _dy, 1, 1, c_white, image_alpha);
    
    if (instance_exists(obj_player)) {
        if (obj_player.encomenda) {
            draw_sprite_ext(spr_pack, 0, x + 4, y + 42, 1, 1, 0, c_white, image_alpha);
        }
        if (obj_player.has_dash) {
            draw_sprite_ext(spr_dash, 0, x + 15, y + 39, 1, 1, 0, c_white, image_alpha);
        }
        if (obj_player.double_jump) {
            draw_sprite_ext(spr_double_jump, 0, x + 27, y + 37, 1, 1, 0, c_white, image_alpha);
        }
    }
}