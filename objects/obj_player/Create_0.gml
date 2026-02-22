// Variáveis
velh = 0;
velv = 0;
mspd = 2;
dir  = sign(image_xscale);

right = 0;
left  = 0;
jump  = 0;

colisoes = [];

keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("W"), vk_space);

inputs = function () {
    dir  = keyboard_check(vk_right) - keyboard_check(vk_left);
    jump = keyboard_check_pressed(vk_space);
};

movement = function () {
    if (dir !=0) dir = sign(dir);
    
    velh = dir * mspd;
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