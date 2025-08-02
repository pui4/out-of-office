shader_type canvas_item;
uniform vec2 scroll_speed = vec2(3.0, 5.0);
uniform float static_intensity : hint_range(0.0, 1.0, 0.05) = 0.25;
uniform vec3 color : source_color = vec3(1.0);
uniform float tex_scale: hint_range(0.5, 10.0, 0.01) = 3.0;
uniform float pixelation : hint_range(1.0, 100.0, 1.0) = 32.0;
uniform float alpha : hint_range(0.0, 1.0, 0.1) = 1;
uniform sampler2D albedo_tex : hint_default_white;

vec2 pixelate_uv(vec2 uv, float pixelation_amount) {
    vec2 pixel_uv = floor(uv * pixelation_amount) / pixelation_amount;
    return pixel_uv;
}

float rand(vec2 co){
	return fract(sin(dot(co ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
	vec2 pixelated_uv = pixelate_uv(UV, pixelation);

	float noise = pow(rand(pixelated_uv * TIME * 0.1), 3) * static_intensity;
	vec3 cnoise = mix(color, vec3(1.0) - color, noise);

	vec3 final = mix(cnoise, cnoise, noise * 0.5);

	COLOR = vec4(final.x, final.y, final.z, alpha);
}