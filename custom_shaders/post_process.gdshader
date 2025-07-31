shader_type canvas_item;

#include "res://addons/ShaderFunction-Extras/Color/color_adjustment.gdshaderinc"

uniform float bands;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;


float rand(vec2 co){
	return fract(sin(dot(co ,vec2(12.9898,78.233))) * 43758.5453);
}


void fragment()
{
	
	
	float noise = pow(rand(UV * TIME * 0.1), 3) * 1.0;
	
	
	vec4 color = texture(screen_texture, SCREEN_UV);
	vec3 hsv_col = rgb_to_hsv(vec3(color.r, color.g, color.b));
	
	hsv_col.z -= noise * 0.1;
	
	hsv_col.z = round(hsv_col.z * bands) / bands;
	vec3 rgb_col = hsv_to_rgb(hsv_col);
	
	
	COLOR.xyz = rgb_col;
	
}