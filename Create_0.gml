
water_width = sprite_width;
water_height = sprite_height;
water_level = y;

node_width = 10;
nodes = ceil(water_width / node_width) + 1;

tension = 0.04;
dampening = 0.03;
spread = 0.15;

node_y = array_create(nodes, water_level);
node_v = array_create(nodes, 0);

wave_timer = 0;
water_color = make_color_rgb(99, 155, 255);

surf_water = -1;