/**
Congrats if you found this! I don't expect
anyone to ever look here.

Inside are layer effects which can be activated with bools.
Change the bool you want in your script, get the element shaded.

All shaders below use base for both parts of the equations-
as if you duplicated a layer and changed one of their modes
*/

shader_type canvas_item;
// get the image or smth? idk
uniform sampler2D image: hint_screen_texture;

// bools for layer modes
uniform bool onoffMult = false;
uniform bool onoffSoftLight = false;


vec4 multiply(vec4 base){
	return base * base;
}

vec4 softlight(vec4 base){
	vec4 limit = step(0.5, base);
	return mix(2.0 * base * base + base * base * (1.0 - 2.0 * base), sqrt(base) * (2.0 * base - 1.0) + (2.0 * base) * (1.0 - base), limit);
}

//unused blend modes- would need to make bools and ifs for them
vec4 screen(vec4 base){
	return 1.0 - (1.0 - base) * (1.0 - base);
}

vec4 overlay(vec4 base){
	vec4 limit = step(0.5, base);
	return mix(2.0 * base * base, 1.0 - 2.0 * (1.0 - base) * (1.0 - base), limit);
}

vec4 color_dodge(vec4 base){
	return base / (1.0 - base);
}

vec4 color_burn(vec4 base){
	return 1.0 - (1.0 - base) / base;
}


void fragment() {
	// Called for every pixel the material is visible on.
	vec4 a = texture(TEXTURE, UV);
	if (onoffSoftLight==true){
		COLOR = softlight(a);
	}
	if (onoffMult==true){
		COLOR = multiply(a);
	}
}
