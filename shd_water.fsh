varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_wave_timer;
uniform vec4 u_water_color;

void main()
{
    vec2 uv = v_vTexcoord;
	
    float distortion = sin(uv.y * 30.0 + u_wave_timer * 3.0) * 0.005;
    
    vec2 refract_uv = uv + vec2(distortion, 0.0);
    
    refract_uv = clamp(refract_uv, 0.0, 1.0);
    
    vec4 bg_color = texture2D(gm_BaseTexture, refract_uv);
    vec4 final_color = mix(bg_color, vec4(u_water_color.rgb, 1.0), u_water_color.a);
    
    gl_FragColor = final_color * v_vColour;
}