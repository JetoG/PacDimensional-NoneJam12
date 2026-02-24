// Variáveis
velh = 0;
velv = 0;
mspd = 1.4;
jspd = 3;
dir  = sign(image_xscale);

right = 0;
left  = 0;
jump  = 0;
chao  = noone;
grav  = 0.2;
rglf  = 0;

xscale = 1;
yscale = 1;

colisoes = [obj_wall, obj_plat];
sprites  = [spr_player_idle, spr_player_walk, spr_player_fall, spr_player_jump];

keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("W"), vk_space);

inputs = function () {
    rglf  = keyboard_check(vk_right) - keyboard_check(vk_left);
    jump = keyboard_check_pressed(vk_space);
};

movement = function () {
    if (rglf != 0) dir = sign(rglf);
    
    velh = rglf * mspd;
    
    if (!chao) {
        velv += grav;
    } else {
        velv = 0;
        if (jump) {
            velv = -jspd;
            squash(0.6, 1.4);
        }
    }
}

colision = function () {
    // --- HORIZONTAL ---    
    // Sistema de Colisão e Movimentação Horizontal
    repeat (abs(velh)) {
        var _velh = sign(velh);
        
        // Subindo Rampas
        if (place_meeting(x + _velh, y, colisoes) and !place_meeting(x + _velh, y - 1, colisoes)) {
            y--;
        }
        
        // Descendo Rampas
        if (!place_meeting(x + _velh, y, colisoes) and 
            !place_meeting(x + _velh, y + 1 , colisoes) and
            place_meeting(x + _velh, y + 2, colisoes)) {
            y++;
        }
        
        // Checando se vou bater na parede 1 pixel por vez
    	if (place_meeting(x + _velh, y, colisoes)) {
            // Você vai parar
            velh = 0;
            break;
        } else {
            x += _velh;
        }
    }
     
    // --- VERTICAL ---
    y = round(y);
    // Sistema de Colisão e Movimentação Vertical
    if (place_meeting(x, y + velv, colisoes)) {
        // Move pixel a pixel até encostar
        var _velv = sign(velv);
        while (!place_meeting(x, y + _velv, colisoes)) {
            y += _velv;
        }
        velv = 0;
    } else {
        // Movimento livre e suave
        y += velv;
    }
    
    // Depois do movimento completo
    var _velh = sign(velh);
    if (place_meeting(x, y, colisoes)) {
        if (place_meeting(x + sign(velh), y, colisoes)) {
            x += (velh + 3) * -sign(_velh);
        }
    }
}

enum states {
    idle,
    walk,
    fall,
    jump
}

estado = states.idle;

state_machine = function () {
    sprite_index = sprites[estado];
    switch (estado) {
    	case 0:
            inputs();
            
            if (velh != 0) {
                estado = states.walk;
            }
            
            if (velv < 0 and !chao) {
                estado = states.jump;
            }
            
            if ((velv == 0 or velv > 0) and !chao) {
                estado = states.fall;
            }
            
            movement();
        break;
        case 1:
            inputs();
            
            if (velh == 0) {
                estado = states.idle;
            }
            
            if (velv < 0 and !chao) {
                estado = states.jump;
            }
            
            if ((velv == 0 or velv > 0) and !chao) {
                estado = states.fall;
            }
            
            movement();
        break;
        case 2:
            inputs();
            
            if (velv == 0 and chao) {
                squash(1.4, 0.6, 0.1);
                estado = states.idle;
            }
            
            movement();
        break;
        case 3:
            inputs();
            
            if ((velv == 0 or velv > 0) and !chao) {
                estado = states.fall;
            }
            
            if (chao) {
                estado = states.idle;
            }
            
            movement();
        break;
    }
}

device = function () {
    if (keyboard_check_pressed(vk_shift)) {
        global.mundo = !global.mundo;
        layer_set_visible(layer_get_id("Sombrio"), global.mundo);
        layer_set_visible(layer_get_id("SombrioExtras"), global.mundo);
        layer_set_visible(layer_get_id("BgSombrio"), global.mundo);
        layer_set_visible(layer_get_id("Normal"), !global.mundo);
        layer_set_visible(layer_get_id("NormalExtras"), !global.mundo);
        layer_set_visible(layer_get_id("BgNormal"), !global.mundo);
    }
}

squash();

//if (!instance_exists(obj_device)) {
    //instance_create_layer(0, 0, "Player", obj_device);
//}