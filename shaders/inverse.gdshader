shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture;

void fragment() {
	vec4 screen_color = texture(screen_tex, SCREEN_UV);
	vec3 inverted = vec3(1.0) - screen_color.rgb;
	float alpha = texture(TEXTURE, UV).a;

	COLOR = vec4(inverted, alpha);
}