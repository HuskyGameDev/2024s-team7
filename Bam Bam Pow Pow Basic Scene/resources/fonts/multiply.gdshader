shader_type canvas_item;
uniform sampler2D image: hint_screen_texture;
uniform bool onoff = false;


vec4 multiply(vec4 base){
	return base * base;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 a = texture(TEXTURE, UV);
	if (onoff==true){
		COLOR = multiply(a);
	}
}
