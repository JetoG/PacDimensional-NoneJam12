image_angle += rotate;

image_alpha = lerp(image_alpha, 0, .05);
if (image_alpha <= 0) {
    instance_destroy();
}