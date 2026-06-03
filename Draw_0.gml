
var _cam = view_camera[0];
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);
var _cam_w = camera_get_view_width(_cam);
var _cam_h = camera_get_view_height(_cam);

if(!surface_exists(surf_water))
{
    surf_water = surface_create(_cam_w, _cam_h);
}

surface_set_target(surf_water);
draw_clear_alpha(c_black, 1.0);
gpu_set_colorwriteenable(true, true, true, false);

draw_surface_stretched(application_surface, 0, 0, _cam_w, _cam_h); 
gpu_set_colorwriteenable(true, true, true, true);
surface_reset_target();

shader_set(shd_water);

shader_set_uniform_f(shader_get_uniform(shd_water, "u_wave_timer"), wave_timer);

var _r = color_get_red(water_color) / 255.0;
var _g = color_get_green(water_color) / 255.0;
var _b = color_get_blue(water_color) / 255.0;
var _alpha = 0.3;
shader_set_uniform_f(shader_get_uniform(shd_water, "u_water_color"), _r, _g, _b, _alpha);

var _tex = surface_get_texture(surf_water);
draw_primitive_begin_texture(pr_trianglestrip, _tex);

for (var i = 0; i < nodes; i++)
{
    var _nx = x + (i * node_width);
    
    var _u = (_nx - _cam_x) / _cam_w;
    var _v_top = (node_y[i] - _cam_y) / _cam_h;
    var _v_bot = ((y + water_height) - _cam_y) / _cam_h;

    draw_vertex_texture(_nx, node_y[i], _u, _v_top);
    draw_vertex_texture(_nx, y + water_height, _u, _v_bot);
}

draw_primitive_end();
shader_reset();

gpu_set_blendmode(bm_add); 
draw_set_color(c_white);

for (var i = 0; i < nodes - 1; i++)
{
    var _nx1 = x + (i * node_width);
    var _ny1 = node_y[i];
    
    var _nx2 = x + ((i + 1) * node_width);
    var _ny2 = node_y[i + 1];
    
    draw_set_alpha(0.5); 
    draw_line(_nx1, _ny1 - 1, _nx2, _ny2 - 1);
    
    draw_set_alpha(0.25); 
    draw_line(_nx1, _ny1, _nx2, _ny2);
    
    draw_set_alpha(0.1); 
    draw_line(_nx1, _ny1 + 1, _nx2, _ny2 + 1);
}

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);

draw_primitive_begin(pr_trianglelist);

for (var i = 1; i < nodes - 1; i += 2)
{
    var _nx = x + (i * node_width);
    var _ny = node_y[i];
    var _deep_y = y + water_height;
	
    var _thickness = 1 + abs(sin(i * 5.32)) * 7; 
	
    var _slant = 30 + sin(i * 3.14) * 15; 
	
    var _sway = sin(wave_timer * 0.5 + i) * 4;
    _slant += _sway;
	
    var _pulse = (sin(wave_timer * 1.2 + i * 2.5) + 1) * 0.5;
    var _alpha_top = 0.05 + (0.15 * _pulse);
    var _alpha_bot = 0.0;
	
    var _tl_x = _nx - _thickness;
    var _tr_x = _nx + _thickness;
    var _bl_x = _nx + _slant - _thickness;
    var _br_x = _nx + _slant + _thickness;
	
    draw_vertex_color(_tl_x, _ny, c_white, _alpha_top);
    draw_vertex_color(_tr_x, _ny, c_white, _alpha_top);
    draw_vertex_color(_bl_x, _deep_y, c_white, _alpha_bot);
	
    draw_vertex_color(_tr_x, _ny, c_white, _alpha_top);
    draw_vertex_color(_bl_x, _deep_y, c_white, _alpha_bot);
    draw_vertex_color(_br_x, _deep_y, c_white, _alpha_bot);
}

draw_primitive_end();

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);